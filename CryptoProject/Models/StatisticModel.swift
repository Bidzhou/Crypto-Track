//
//  SatisticModel.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 24.10.2024.
//

import Foundation

struct StatisticModel: Identifiable {
    var id = UUID().uuidString //creates a random id
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, persentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = persentageChange
    }
    
}
