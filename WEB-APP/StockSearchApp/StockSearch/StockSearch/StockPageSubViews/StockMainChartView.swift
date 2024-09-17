//
//  StockMainChartView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 5/1/24.
//

import SwiftUI

//struct StockMainChartView: View {
//    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////        let histManager = HistManager(ticker: ticker)
//        
//        @ObservedObject var viewModel = StockDetailsViewModel()
//                TabView {
////                    StockMainChartHourlyView(viewModel: viewModel, symbol: "AAPL")
//                    StockMainChartHourlyView()
//                        .tabItem {
//                            Label("Hourly", systemImage: "chart.xyaxis.line")
//                        }
//                    
////                    StockMainChartHistoricalView(stockViewModel: viewModel)
//                    StockMainChartHistoricalView()
//                        .tabItem {
//                            Label("Historical", systemImage: "clock")
//                        }
//                }
//                .frame(width: 320.0, height: 400.0)
//                .padding()
//            }
//    }
//
//import SwiftUI
//
//struct StockMainChartView: View {
//    var ticker: String
//    @StateObject var viewModel = StockDetailsViewModel() // Changed to @StateObject for ownership and initialization
//
//    var body: some View {
//        TabView {
//            if let changePercent = viewModel.stockDetails?.changePercent {
//                // Only display the hourly chart if changePercent is available
//                StockMainChartHourlyView(stockViewModel: viewModel, ticker: ticker, changePercent: changePercent)
//                    .tabItem {
//                        Label("Hourly", systemImage: "chart.xyaxis.line")
//                    }
//            } else {
//                // Optionally provide a placeholder or different view if changePercent is not available
//                Text("Loading Hourly Data...")
//                    .tabItem {
//                        Label("Hourly", systemImage: "chart.xyaxis.line")
//                    }
//            }
//
//            StockMainChartHistoricalView(stockViewModel: viewModel, ticker: ticker)
//                .tabItem {
//                    Label("Historical", systemImage: "clock")
//                }
//        }
//        .frame(width: 320.0, height: 400.0)
//        .padding()
//        .onAppear {
//            viewModel.loadAllData(for: ticker) // Ensuring data is loaded upon view appearance
//        }
//    }
//}



//struct StockMainChartHourlyView: View {
//    var body: some View {
//        Text("Hourly Chart Content")
//            .frame(width: 200, height: 200) // Explicit frame size
//            .background(Color.blue) // Background color for debugging
//    }
//}


//struct StockMainChartHistoricalView: View {
//    var body: some View {
//        Text("Hourly Chart Content")
//            .frame(width: 200, height: 200) // Explicit frame size
//            .background(Color.blue) // Background color for debugging
//    }
//}



//
//import SwiftUI
//import WebKit
//
//struct HistoricalChart: View {
//    @ObservedObject var stockViewModel: StockViewModel
//
//    var body: some View {
//        VStack {
//            if stockViewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let errorMessage = stockViewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//            } else {
//                WebView(htmlContent: generateChartHTML())
//                    .frame(maxWidth: .infinity, maxHeight: 400)
//            }
//        }
//        .onAppear {
//            stockViewModel.loadStockPriceData(for: "AAPL") // Assume "AAPL" or any other ticker
//        }
//    }
//
//    private func generateChartHTML() -> String {
//        let stockPriceData = stockViewModel.stockPriceData.map { "[\($0.timestamp), \($0.price)]" }.joined(separator: ",")
//        let volumeData = stockViewModel.volumeData.map { "[\($0.timestamp), \($0.volume)]" }.joined(separator: ",")
//
//        let chartOptions = """
//            {
//                chart: {
//                    type: 'stockChart'
//                },
//                rangeSelector: {
//                    selected: 2
//                },
//                title: {
//                    text: 'AAPL Hourly Prices'
//                },
//                series: [{
//                    type: 'line',
//                    name: 'AAPL Price',
//                    data: [\(stockPriceData)],
//                    tooltip: {
//                        valueDecimals: 2
//                    }
//                }, {
//                    type: 'column',
//                    name: 'Volume',
//                    data: [\(volumeData)],
//                    yAxis: 1
//                }],
//                yAxis: [
//                    {
//                        title: {
//                            text: 'Price'
//                        },
//                        height: '70%',
//                        resize: {
//                            enabled: true
//                        }
//                    }, {
//                        title: {
//                            text: 'Volume'
//                        },
//                        top: '75%',
//                        height: '25%',
//                        offset: 0,
//                        lineWidth: 2
//                    }
//                ],
//                tooltip: {
//                    split: true
//                }
//            }
//        """
//
//        let html = """
//            <html>
//            <head>
//                <meta name="viewport" content="width=device-width, initial-scale=0.85">
//                <script src="https://code.highcharts.com/stock/highstock.js"></script>
//                <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
//                <script src="https://code.highcharts.com/modules/accessibility.js"></script>
//                <style>
//                    body { margin: 0; display: flex; justify-content: center; align-items: center; }
//                    #container { height: 90%; width: 100% }
//                </style>
//            </head>
//            <body>
//                <div id="container"></div>
//                <script>
//                    Highcharts.stockChart('container', \(chartOptions));
//                </script>
//            </body>
//            </html>
//        """
//
//        return html
//    }
//}
//
//
//#Preview {
//    StockMainChartView()
//}


import SwiftUI

struct StockMainChartView: View {
    var ticker: String
    @StateObject var viewModel = StockDetailsViewModel() // Changed to @StateObject for ownership and initialization

    var body: some View {
        TabView {
            if let changePercent = viewModel.stockDetails?.changePercent {
                // Only display the hourly chart if changePercent is available
                StockMainChartHourlyView(stockViewModel: viewModel, ticker: ticker, changePercent: changePercent)
                    .tabItem {
                        Label("Hourly", systemImage: "chart.xyaxis.line")
                    }
            } else {
                // Optionally provide a placeholder or different view if changePercent is not available
                Text("Loading Hourly Data...")
                    .tabItem {
                        Label("Hourly", systemImage: "chart.xyaxis.line")
                    }
            }

            StockMainChartHistoricalView(stockViewModel: viewModel, ticker: ticker)
                .tabItem {
                    Label("Historical", systemImage: "clock")
                }
        }
        .frame(height: 400.0) // Set the height to 400.0
        .frame(width: 370.0) // Set the maxWidth to occupy the available width
//        .padding(.horizontal)
        .padding(.leading,0)
        .onAppear {
            viewModel.loadAllData(for: ticker) // Ensuring data is loaded upon view appearance
        }
    }
}

