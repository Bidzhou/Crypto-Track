//
//  HomeStatsView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 24.10.2024.
//

import SwiftUI

struct HomeStatsView: View {
    
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @Binding var isShowPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width
               , alignment: isShowPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(isShowPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.shared.homeVM)
}
