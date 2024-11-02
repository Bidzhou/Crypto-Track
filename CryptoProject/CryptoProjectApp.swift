//
//  CryptoProjectApp.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 15.10.2024.
//

import SwiftUI

@main
struct CryptoProjectApp: App {
    @StateObject private var vm = HomeViewModel()
    @State private var isShowLaunchView: Bool = true
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                NavigationView {
                    HomeView()
                        .toolbar(.hidden)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                
                .environmentObject(vm)
                
                ZStack {
                    if isShowLaunchView {
                        LaunchView(isShowLaunchView: $isShowLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0) //чем выше значение тем выше view

            }
            
            

        }
    }
}
