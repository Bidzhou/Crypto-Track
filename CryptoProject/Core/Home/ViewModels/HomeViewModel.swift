//
//  HomeViewModel.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 21.10.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText = ""
    @Published var statistics: [StatisticModel] = []
    @Published var isLoading : Bool = false
    @Published var sortOption: SortOptions = .holdings
    
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOptions {
        case rank
        case rankReversed
        case holdings
        case holdingsReversed
        case price
        case priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        //useless cause we subscribing dataService.$allCoins as well as we subscribing $searchText
//        dataService.$allCoins //подписываемся на allCoins в coindataservice
//            .sink {[weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
        
        
        //update allCoins
        $searchText                             //подписываемся сразу на несколько издателей
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) //эта строчка означает что код ниже будет выполняться через 0.5 сек, если издатель не опубликует изменение. Это нужно на случай если человек быстро печатает, чтобы не делать много лишних запросов. Если издатель опубликует значение, код выполняться не будет
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink {[weak self]  returnedCoins in
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfilioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        //update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(transformMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        

        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadeData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sortOption: SortOptions) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        //sort
        sortCoins(sort: sortOption, coins: &updatedCoins)
        //let sortedCoins = sortCoins(sort: sortOption, coins: filteredCoins)
        return updatedCoins
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        let loweredText = text.lowercased()
        return coins.filter{ coin -> Bool in
            return coin.name.lowercased().contains(loweredText) ||
            coin.symbol.lowercased().contains(loweredText) ||
            coin.id.lowercased().contains(loweredText)
        }
    }
    
    
    
//    private func sortCoins(sort: SortOptions, coins: [CoinModel]) -> [CoinModel] {
//        switch sort {
//        case .rank, .holdings:
//            return coins.sorted {$0.rank < $1.rank}
//        case .rankReversed, .holdingsReversed:
//            return coins.sorted {$0.rank > $1.rank}
//        case .price:
//            return coins.sorted(by: {$0.currentPrice > $1.currentPrice})
//        case .priceReversed:
//            return coins.sorted(by: {$0.currentPrice < $1.currentPrice})
//            
//        }
//        
//    }
    
    private func sortCoins(sort: SortOptions, coins: inout [CoinModel]) { //теперь мы не создаем новый массив как в функции выше, а меняем входящий(return не нужен)
        switch sort {
        case .rank, .holdings:
            coins.sort {$0.rank < $1.rank}
        case .rankReversed, .holdingsReversed:
            coins.sort {$0.rank > $1.rank}
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
        
    }
    
    private func sortPortfilioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(coins: [CoinModel], entities: [PortfolioEntity]) -> [CoinModel] {
        coins
        .compactMap { coin -> CoinModel? in
            guard let entity = entities.first(where: {$0.coinID == coin.id}) else {
                 return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func transformMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel]{
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {return stats}
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, persentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
                                .map({$0.currentHoldingsValue})
                                .reduce(0, +)
        let previousValue =
            portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        let percentageChange = previousValue != 0 ? ((portfolioValue - previousValue) / previousValue): 0
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            persentageChange: percentageChange
        )
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats
    }

}
