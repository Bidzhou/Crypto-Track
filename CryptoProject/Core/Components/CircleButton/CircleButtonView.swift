//
//  CircleButtonView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 15.10.2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background {
                Circle()
                    .foregroundColor(Color.theme.background)
            }
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,
                x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/
            )
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CircleButtonView(iconName: "plus")
            .padding()
        
//        CircleButtonView(iconName: "info")
//            .padding()
//            //.preferredColorScheme(.dark)
//            .colorScheme(.dark)
    }

}
