//
//  MarketDataModel.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 25.10.2024.
//

import Foundation

/*
 url = https://api.coingecko.com/api/v3/global
 response :
 {
   "data": {
     "active_cryptocurrencies": 15009,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1140,
     "total_market_cap": {
       "btc": 35705100.4380762,
       "eth": 969255338.956809,
       "ltc": 33792140659.4156,
       "bch": 6580528160.70296,
       "bnb": 4089197220.8316,
       "eos": 5166513858183.08,
       "xrp": 4622488680917.35,
       "xlm": 25080622733120.7,
       "link": 204511882554.819,
       "dot": 585982255642.9,
       "yfi": 491795171.668919,
       "usd": 2414657876877.71,
       "aed": 8869014235193.05,
       "ars": 2379041636973892,
       "aud": 3644406913703.37,
       "bdt": 287946742074070,
       "bhd": 910147334900.005,
       "bmd": 2414657876877.71,
       "brl": 13680244201450.7,
       "cad": 3344815481603.4,
       "chf": 2090516618143.52,
       "clp": 2286367103879193,
       "cny": 17208542291144.3,
       "czk": 56302580129815.3,
       "dkk": 16654803288187.2,
       "eur": 2232505745277.56,
       "gbp": 1862872332143,
       "gel": 6567869425107.37,
       "hkd": 18765066978447.9,
       "huf": 901748133403942,
       "idr": 37795754936436880,
       "ils": 9148894815044.06,
       "inr": 203013447594538,
       "jpy": 366697189156279,
       "krw": 3.35650959001741e+15,
       "kwd": 739754587160.253,
       "lkr": 707695481190497,
       "mmk": 5065952225689436,
       "mxn": 47899396862913.7,
       "myr": 10474785869895.5,
       "ngn": 3.96378163778861e+15,
       "nok": 26439979771051.6,
       "nzd": 4023624103951.27,
       "php": 141128294356959,
       "pkr": 669387921568904,
       "pln": 9704819083379.75,
       "rub": 234584041714564,
       "sar": 9069360813895.47,
       "sek": 25544144113387.8,
       "sgd": 3187176956769.31,
       "thb": 81562313765175.2,
       "try": 82804930513826.7,
       "twd": 77456188045544.7,
       "uah": 99402245627281.3,
       "vef": 241779693211.765,
       "vnd": 61340231867351680,
       "zar": 42712438887040.3,
       "xdr": 1807815717892.31,
       "xag": 71957867180.4214,
       "xau": 883837222.673548,
       "bits": 35705100438076.2,
       "sats": 3.57051004380762e+15
     },
     "total_volume": {
       "btc": 1407128.72413107,
       "eth": 38198100.8799819,
       "ltc": 1331739476.66685,
       "bch": 259336903.727176,
       "bnb": 161154199.189227,
       "eos": 203610967740.561,
       "xrp": 182171076963.367,
       "xlm": 988420820383.226,
       "link": 8059760113.77131,
       "dot": 23093408326.2494,
       "yfi": 19381519.8376065,
       "usd": 95161039062.0997,
       "aed": 349525544864.702,
       "ars": 93757412308518.2,
       "aud": 143625128840.841,
       "bdt": 11347906232474.8,
       "bhd": 35868669809.5209,
       "bmd": 95161039062.0997,
       "brl": 539134866806.326,
       "cad": 131818308402.328,
       "chf": 82386716339.4425,
       "clp": 90105133056730.3,
       "cny": 678184177083.866,
       "czk": 2218870042972.02,
       "dkk": 656361466961.988,
       "eur": 87982470919.4112,
       "gbp": 73415314220.824,
       "gel": 258838026248.911,
       "hkd": 739526410278.882,
       "huf": 35537659462543.4,
       "idr": 1.48952087429402e+15,
       "ils": 360555565741.351,
       "inr": 8000707181613.61,
       "jpy": 14451440875087.6,
       "krw": 132279170174192,
       "kwd": 29153535927.0648,
       "lkr": 27890094896889.3,
       "mmk": 199647859952286,
       "mxn": 1887702775441.09,
       "myr": 412808587451.388,
       "ngn": 156211603672390,
       "nok": 1041992727784.51,
       "nzd": 158569979703.466,
       "php": 5561829384059.89,
       "pkr": 26380403933034,
       "pln": 382464396603.579,
       "rub": 9244896086815.46,
       "sar": 357421151436.723,
       "sek": 1006688077453.51,
       "sgd": 125605815128.198,
       "thb": 3214349577439.61,
       "try": 3263320780395.51,
       "twd": 3052528230514.51,
       "uah": 3917416653339.51,
       "vef": 9528474841.28804,
       "vnd": 2.41740258804496e+15,
       "zar": 1683286110338.29,
       "xdr": 71245547369.169,
       "xag": 2835840834.90775,
       "xau": 34831795.1279004,
       "bits": 1407128724131.07,
       "sats": 140712872413107
     },
     "market_cap_percentage": {
       "btc": 55.3776512526325,
       "eth": 12.4306593792056,
       "usdt": 4.97806909967432,
       "bnb": 3.56765331197642,
       "sol": 3.38127870696528,
       "usdc": 1.42784800496897,
       "xrp": 1.22793753812591,
       "steth": 1.005604278032,
       "doge": 0.846390175461454,
       "trx": 0.594871278384899
     },
     "market_cap_change_percentage_24h_usd": -1.56643747157665,
     "updated_at": 1729839816
   }
 }
 */


struct GlobalDataModel: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
//        if let item = totalMarketCap.first(where: { key, value in
//            return key == "usd"
//        }) {
//            return "\(item.value)"
//        }
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
    
    
}
