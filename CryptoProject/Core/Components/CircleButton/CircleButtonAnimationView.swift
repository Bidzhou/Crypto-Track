//
//  CircleButtonAnimationView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 16.10.2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var isAnimate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(isAnimate ? 1.0 : 0.0)
            .opacity(isAnimate ? 0.0 : 1.0)
            .animation(isAnimate ? Animation.easeOut(duration: 0.7) : .none, value: isAnimate)

    }
}

#Preview {
    CircleButtonAnimationView(isAnimate: .constant(false))
        .foregroundStyle(Color.red)
        .frame(width: 100, height: 100)
}
