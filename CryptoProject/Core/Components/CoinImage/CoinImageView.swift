//
//  CoinImageView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 23.10.2024.
//

import SwiftUI



struct CoinImageView: View {
    ///ATTENTION
    @StateObject var vm: CoinImageViewModel
    init(coin: CoinModel) {
        _vm  = StateObject(wrappedValue: CoinImageViewModel(coin: coin))//underscore to reference to stateobject
    }
    ///ATTENTION
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable() 
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImageView(coin: DeveloperPreview.shared.coin)
        .padding()
}
