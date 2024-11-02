//
//  CoinModel.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 16.10.2024.
//

import Foundation

//Coin API info
/*
 --url 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_asc&per_page=5&page=1&sparkline=true&price_change_percentage=24h&x_cg_demo_api_key=CG-AwdQzj6fKs3srNm8HXM7QFoL' \

    JSON Response:
 {
   "id": "0-mee",
   "symbol": "ome",
   "name": "O-MEE",
   "image": "https://coin-images.coingecko.com/coins/images/25099/large/logo-mark-full-colour-cmyk-693px_300ppi.jpg?1696524249",
   "current_price": 0.00006044,
   "market_cap": 0,
   "market_cap_rank": null,
   "fully_diluted_valuation": 48351,
   "total_volume": 16.74,
   "high_24h": 0.0000606,
   "low_24h": 0.00005691,
   "price_change_24h": -2.7554113896e-8,
   "price_change_percentage_24h": -0.04557,
   "market_cap_change_24h": 0,
   "market_cap_change_percentage_24h": 0,
   "circulating_supply": 0,
   "total_supply": 800000000,
   "max_supply": null,
   "ath": 0.00309228,
   "ath_change_percentage": -98.04356,
   "ath_date": "2023-09-26T19:05:27.965Z",
   "atl": 0.00002513,
   "atl_change_percentage": 140.77414,
   "atl_date": "2024-08-26T18:15:11.946Z",
   "roi": null,
   "last_updated": "2024-10-18T14:14:07.157Z",
   "sparkline_in_7d": {
     "price": [
       0.00006235974916272952,
       0.00006632663221650982,
       0.0000663471016082199,
       0.00006630215815357437,
       0.00006634153518801669,
       0.00006633316973048492,
       0.00006636682378580484,
       0.00006631728927553585,
       0.0000663352570212375,
     ]
   },
   "price_change_percentage_24h_in_currency": -0.045569024803580764
 }
 */

//cmd + option + left/right arrow( code folding )

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage:  Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
            return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}
