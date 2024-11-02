//
//  SearchBarView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 24.10.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.theme.secondary : Color.theme.accent
                )
                
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .disableAutocorrection(true)
                
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                    //exta padding 4 bigger button space
                        .padding()
                        .offset(x: 10)
                        
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    
                    ,alignment: .trailing
                )

        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.25),
                    radius: 10
                )
        )
        .padding()
    }
}

#Preview("typeshit", traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
}
