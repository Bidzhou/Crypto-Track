//
//  Date.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 30.10.2024.
//

import Foundation

extension Date {
    
    //"2023-09-26T19:05:27.965Z"
    init(coinGekoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGekoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
