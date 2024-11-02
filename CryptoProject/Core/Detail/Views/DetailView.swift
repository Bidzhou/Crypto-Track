//
//  DetailView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 28.10.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)

            }
        }
        
        
    }
    
}

struct DetailView: View {
    @StateObject private var vm: DetailViewModel
    @State private var isShowFullDescription: Bool = false
    //lazyvgrid settings
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
       
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    linkSection

                }
                .padding()
                
            }
            

        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
                
            }
        }
    }
}

#Preview {
    NavigationView {
        DetailView(coin: DeveloperPreview.shared.coin)

    }
}

extension DetailView {
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondary)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25, alignment: .trailing)
        }
    }
    
    private var overviewTitle: some View{
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.overViewStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(isShowFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondary)
                    Button {
                        withAnimation(.easeInOut) {
                            isShowFullDescription.toggle()
                        }
                    } label : {
                        Text(!isShowFullDescription ? "Read more..." : "Hide description")
                            .foregroundStyle(.blue)
                            .font(.caption)
                            .bold()
                            .padding(.vertical,4)
                            
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var linkSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
                    
            }
            
            if let redditURL = vm.redditURL, let url = URL(string: redditURL) {
                Link("Reddit", destination: url)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color.blue)
            .font(.headline)
    }
}
