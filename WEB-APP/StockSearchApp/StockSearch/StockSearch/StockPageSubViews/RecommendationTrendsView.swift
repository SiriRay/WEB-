//
//  RecommendationTrendsView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//

//import SwiftUI
//
//struct RecommendationTrendsView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    RecommendationTrendsView()
//}


//import SwiftUI
//import WebKit
//
//// RecommendationTrendsView that uses the WebView to display the Highcharts graph
//
//struct RecommendationTrendsView: View {
//    @ObservedObject var viewModel: StockDetailsViewModel
//    
//    var body: some View {
//        VStack {
//            if viewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage)
//            } else {
//                WebView(htmlContent: generateChartHTML())
//                    .frame(height: 400)
//                    .frame(maxWidth: .infinity, alignment: .center)
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//        .padding(.bottom,0)
//    }
//    
//    private func generateChartHTML() -> String {
//        let periods = viewModel.recommendationTrends.map { "\"\($0.period)\"" }.joined(separator: ",")
//        let strongBuyData = viewModel.recommendationTrends.map { $0.strongBuy }
//        let buyData = viewModel.recommendationTrends.map { $0.buy }
//        let holdData = viewModel.recommendationTrends.map { $0.hold }
//        let sellData = viewModel.recommendationTrends.map { $0.sell }
//        let strongSellData = viewModel.recommendationTrends.map { $0.strongSell }
//
//        let chartOptions = """
//        {
//            chart: { type: 'column', backgroundColor: 'white' },
//            title: { text: 'Recommendation Trends' },
//            xAxis: {
//                
//                type: 'datetime',
//                dateTimeLabelFormats: { month: '%Y-%m' },
//                categories:  \(viewModel.recommendationTrends.map { "\($0.period.split(separator: "-").prefix(2).joined(separator: "-"))" }),
//            },
//            yAxis: {
//                min: 0,
//                title: { text: '#Analysis' },
//                tickInterval: 20
//            },
//            tooltip: {
//                            
//                            headerFormat: '<span>{point.key}</span><br/>',
//                            pointFormat: '<span style="{series.color}">{series.name}</span>:{point.y}<br/>',
//                            footerFormat: 'Total: {point.total}',
//                            shared: true,
//                            useHTML: true
//                        },
//            plotOptions: {
//                column: {
//                    stacking: 'normal',
//                    dataLabels: {
//                        enabled: true
//                    }
//                }
//            },
//        legend: {
//                               
//                               
//                               useHTML: true,
//                               layout: 'horizontal',
//                               
//                           },
//            series: [
//                { name: 'Strong Buy', data: \(strongBuyData), color: '#195f32' },
//                { name: 'Buy', data: \(buyData), color: '#23af50' },
//                { name: 'Hold', data: \(holdData), color: '#af7d28' },
//                { name: 'Sell', data: \(sellData), color: '#f05050' },
//                { name: 'Strong Sell', data: \(strongSellData), color: '#732828' }
//            ]
//        }
//        """
//
//        let html = """
//        <html>
//        <head>
//        <meta name="viewport" content="width=device-width, initial-scale=0.95">
//        <script src="https://code.highcharts.com/highcharts.js"></script>
//        <script src="https://code.highcharts.com/modules/exporting.js"></script>
//        <style>
//            body {
//                display: flex;
//                justify-content: center;
//                align-items: flex-start;
//            }
//            #container {
//                width: 100%;
//                height: 80%;
//            }
//        </style>
//        </head>
//        <body>
//        <div id="container"></div>
//        <script>
//        Highcharts.chart('container', \(chartOptions));
//        </script>
//        </body>
//        </html>
//        """
//        
//        return html
//    }
//}


import SwiftUI
import WebKit

// RecommendationTrendsView that uses the WebView to display the Highcharts graph

struct RecommendationTrendsView: View {
    @ObservedObject var viewModel: StockDetailsViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                WebView(htmlContent: generateChartHTML())
                    .frame(height: 400)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.bottom, 0)
    }
    
    private func generateChartHTML() -> String {
        let strongBuyData = viewModel.recommendationTrends.map { $0.strongBuy }
        let buyData = viewModel.recommendationTrends.map { $0.buy }
        let holdData = viewModel.recommendationTrends.map { $0.hold }
        let sellData = viewModel.recommendationTrends.map { $0.sell }
        let strongSellData = viewModel.recommendationTrends.map { $0.strongSell }

        let chartOptions = """
        {
            chart: { type: 'column' },
            title: { text: 'Recommendation Trends' },
            xAxis: {
                            
                            type: 'datetime',
                            dateTimeLabelFormats: { month: '%Y-%m' },
                            categories:  \(viewModel.recommendationTrends.map { "\($0.period.split(separator: "-").prefix(2).joined(separator: "-"))" }),
                        },
            yAxis: {
                allowDecimals: false,
                min: 0,
                title: { text: '#Analysis' }
            },
            tooltip: {
                format: '<b>{key}</b><br/>{series.name}: {y}<br />Total: {point.stackTotal}'
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: { enabled: true }
                }
            },
            series: [
                { name: 'Strong Buy', data: \(strongBuyData), type: 'column', color: '#195f32' },
                { name: 'Buy', data: \(buyData), type: 'column', color: '#23af50' },
                { name: 'Hold', data: \(holdData), type: 'column', color: '#af7d28' },
                { name: 'Sell', data: \(sellData), type: 'column', color: '#f05050' },
                { name: 'Strong Sell', data: \(strongSellData), type: 'column', color: '#732828' }
            ]
        }
        """

        let html = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=0.95">
            <script src="https://code.highcharts.com/highcharts.js"></script>
            <script src="https://code.highcharts.com/modules/exporting.js"></script>
            <style>
                body { display: flex; justify-content: center; align-items: flex-start; }
                #container { width: 100%; height: 80%; }
            </style>
        </head>
        <body>
            <div id="container"></div>
            <script>
                Highcharts.chart('container', \(chartOptions));
            </script>
        </body>
        </html>
        """
        
        return html
    }
}
