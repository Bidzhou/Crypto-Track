//
//  LaunchView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 1.11.2024.
//

import SwiftUI

struct LaunchView: View {
    @Environment (\.dismiss) var dismiss
    @State private var loadingText: [String] = "Loading your portfolio...".map{ String($0) }
    @State private var isShowLoadingText: Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var isShowLaunchView: Bool
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack {
                if isShowLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.launch.accent)
                                .offset(y: counter == index ? -5 : 0)
                                
                            
                        }
                    }.transition(AnyTransition.scale.animation(.easeInOut))
                }

                    
            }
            .offset(y: 70.0)
        }.onAppear(perform: {
            isShowLoadingText.toggle()
        })
        .onReceive(timer, perform: { _ in
            withAnimation {
                let lastIndex = loadingText.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops > 2 {
                        isShowLaunchView.toggle()
                    }
                } else {
                    counter += 1
                }
                
                
                
            }
        })
    }
}

#Preview {
    LaunchView(isShowLaunchView: .constant(true))
}
