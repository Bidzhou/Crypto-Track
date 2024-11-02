//
//  SettingsView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 1.11.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment (\.dismiss) var dismiss
    
    private let url = URL(string: "https://www.google.com")!
    private let youtube = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    private let coinGeko = URL(string: "https://www.coingeko.com")!
    private let myGit = URL(string: "https://github.com/Bidzhou")!
    var body: some View {
        NavigationView {
            ZStack {
                //background
                Color.theme.background
                    .ignoresSafeArea()
                
                //content layer
                List {
                    coinGekoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    swiftfulThinkingSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    devSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
                .scrollContentBackground(.hidden)
            }
            
            .listStyle(.grouped)
            .font(.headline)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: _dismiss) //
                }
            }
            
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                Text("This app was made by following a @SwiftfulThinking course on youTube")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("youtube link", destination: youtube)
                .foregroundStyle(.blue)
        } header: {
            Text("Thanks 2 my dawg swiftful thinking")
        }
    }
    
    private var coinGekoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                Text("The cryptocurrency data that used in this app comes from a free api from Coin Gecko!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("visit coin gecko", destination: coinGeko)
                .foregroundStyle(.blue)
        } header: {
            Text("Coin Gecko")
        }
    }
    
    private var devSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("wlr")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                Text("Another app 4 practice")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("My git", destination: myGit)
                .foregroundStyle(.blue)
        } header: {
            Text("About me")
        }
    }
    
    private var applicationSection: some View {
        Section {

            Link("Terms of Service", destination: url)
                .foregroundStyle(.blue)
            Link("Privacy Policy", destination: url)
                .foregroundStyle(.blue)
            Link("Company Website", destination: url)
                .foregroundStyle(.blue)
            Link("Learn More", destination: url)
                .foregroundStyle(.blue)
        } header: {
            Text("Application")
        }
    }
}
