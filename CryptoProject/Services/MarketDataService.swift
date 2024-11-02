//
//  MarketDataService.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 25.10.2024.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var marketSubscription: AnyCancellable?
    
    init() {
        getMarketData()
        
    }
    
    func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
        
        marketSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalDataModel .self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketSubscription?.cancel()
            })
            
    }
}
