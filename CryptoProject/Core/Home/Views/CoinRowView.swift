//
//  CoinRowView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 18.10.2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let isShowHoldings: Bool
    
    
    var body: some View {
        HStack(spacing: 0){
            
            leftColumn
            
            Spacer()
            if isShowHoldings {

                   cenerColumn
            }
            Spacer()
            
            rightColumn
            
        }.font(.subheadline)
            .background(
                Color.theme.background //для того чтобы вся область реагировала на tapgesture
            )
    }
}

#Preview(traits: .sizeThatFitsLayout)  {
        CoinRowView(coin: DeveloperPreview.shared.coin, isShowHoldings: true)
            
        

}


extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondary)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width:30, height: 30)
            Text("\(coin.symbol)")
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var cenerColumn: some View {
        VStack (alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .frame(minWidth: 100, alignment: .trailing)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
    }
}
