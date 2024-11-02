//
//  String.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 1.11.2024.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        //return self.replacingOccurrences(of: "<[^>]+>", with: "")
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
