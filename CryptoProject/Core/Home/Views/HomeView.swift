//
//  HomeView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 15.10.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var isShowPortfolio: Bool = false // for animation of circle button
    @State private var isShowPortfolioView: Bool = false //for new sheet
    @State private var selectCoin: CoinModel? = nil
    @State private var isShowDetailView: Bool = false
    @State private var isShowSettingsView: Bool = false
    
    var body: some View {
        ZStack {
            //background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $isShowPortfolioView, content: { //we need to manualy add vm to this sheet cause there is new environment
                    PortfolioView()
                        .environmentObject(vm)
                })
            //content layer
            
            VStack {
                homeHeader
                
                HomeStatsView(isShowPortfolio: $isShowPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !isShowPortfolio {
                    allCoinList
                        .transition(.move(edge: .leading))
                }
                if isShowPortfolio {
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                           portfolioEmptyText
                        } else {
                            portfolioCoinList
                                
                        }
                    }.transition(.move(edge: .trailing))
                    
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $isShowSettingsView, content: {
                SettingsView()
            })
        }

        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectCoin),
                isActive: $isShowDetailView,
                label: {EmptyView()}
            )
            
        )
    }
}

#Preview {
    NavigationView {
        HomeView()
        .toolbar(.hidden)
            
    }
    .environmentObject(DeveloperPreview.shared.homeVM)
    
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: isShowPortfolio ? "plus" : "info")
                .animation(.none, value: isShowPortfolio)
                .onTapGesture {
                    if isShowPortfolio {
                        isShowPortfolioView.toggle()
                    } else {
                        isShowSettingsView.toggle()
                    }
                }
                .background(CircleButtonAnimationView(isAnimate: $isShowPortfolio))
            Spacer()
            Text(isShowPortfolio ? "Portfolio" : "Live Prices")
                .animation(.none, value: isShowPortfolio)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(isShowPortfolio ? 180 : 0))
                .onTapGesture {
                    
                    withAnimation(.smooth(duration: 0.5, extraBounce: 0.2)) {
                        isShowPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinList: some View {
        List {
            ForEach(vm.allCoins) { coin in

                CoinRowView(coin: coin, isShowHoldings: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(.plain)
        .refreshable {
            vm.reloadeData()
        }
    }
    private func segue(coin: CoinModel){
        selectCoin = coin
        isShowDetailView.toggle()
    }
    
    private var portfolioCoinList: some View {
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, isShowHoldings: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            
            Spacer()
            if isShowPortfolio {
                
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
        
            }
            
        
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            Button {
                withAnimation(.linear(duration: 2)) {
                    vm.reloadeData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondary)
        .padding(.horizontal)
    }
    
    private var portfolioEmptyText: some View {
        Text("You haven't added any coins to your portfolio yet! Click the + button to get started.")
            .font(.callout)
            .foregroundStyle(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
}
