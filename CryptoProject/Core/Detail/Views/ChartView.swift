//
//  ChartView.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 30.10.2024.
//

import SwiftUI

struct ChartView: View {
    @State private var percentage: CGFloat = 0
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.maxY = data.max() ?? 0
        self.minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        endingDate = Date(coinGekoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60) // за 7 дней до конца
        
    }
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay (
                    chartYAxisView.padding(.horizontal,4),
                    alignment: .leading
                )
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondary)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.shared.coin)
        //.frame(width: 100)
}

extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = (geometry.size.width / CGFloat(data.count)) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1-CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0), radius: 10, x: 0.0, y: 10)
                        .shadow(color: lineColor.opacity(1), radius: 10, x: 0.0, y: 10)
                        .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 10)
            
            
        }
    }
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    private var chartYAxisView : some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            let price = ((maxY + minY) / 2).formattedWithAbbreviations()
            Text(price)
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack{
            Text("\(startingDate.asShortDateString())")
            Spacer()
            Text("\(endingDate.asShortDateString())")
            
        }
    }
}
