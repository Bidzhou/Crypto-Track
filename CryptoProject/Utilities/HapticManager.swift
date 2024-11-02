//
//  HapticManager.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 27.10.2024.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
