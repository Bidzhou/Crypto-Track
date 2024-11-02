//
//  Double.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 19.10.2024.
//

import Foundation

extension Double {
    
    
    ///converts double into a currency with a 2 decimal places
    ///```
    ///1234.56  to $1,234.56
    ///```
    private var currencyFormater2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true //Определяет, будет ли приемник отображать разделитель групп.
        formatter.numberStyle = .currency
        //formatter.locale = .current //с помощью этой строки можно изменять валюты отображаемые у пользователя в зависимости от региона пользователя
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    ///converts double into a currency with a 2 decimal places as a string
    ///```
    ///1234.56  to $1,234.56
    ///```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormater2.string(from: number) ?? "$0.00"
    }
    
    ///converts double into a currency with a 2-6 decimal places
    ///```
    ///0.123414 to $0.123414
    ///1.234    to $1.234
    ///1234.56  to $1,234.56
    ///```
    private var currencyFormater6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true //Определяет, будет ли приемник отображать разделитель групп.
        formatter.numberStyle = .currency
        //formatter.locale = .current //с помощью этой строки можно изменять валюты отображаемые у пользователя в зависимости от региона пользователя
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$" 
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    ///converts double into a currency with a 2-6 decimal places as a string
    ///```
    ///0.123414 to $0.123414
    ///1.234    to $1.234
    ///1234.56  to $1,234.56
    ///```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormater6.string(from: number) ?? "$0.00"
    }
    
    
    ///converts double into string
    ///```
    ///convert 1.2345 to 1.23
    ///```
    func asNumberString() -> String {
        return String(format: "%.2f", self) // "%.2f" - > jзначает 2 знака после запятой
    }
    
    ///converts double into string with % symbol
    ///```
    ///convert 1.2345 to 1.23%
    ///```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }

}
