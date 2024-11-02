//
//  UIApplication.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 24.10.2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
