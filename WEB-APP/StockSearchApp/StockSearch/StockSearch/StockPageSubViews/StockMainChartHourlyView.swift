//
//  StockMainChartHourlyView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 5/1/24.
//

//import SwiftUI
//
//struct StockMainChartHourlyView: View {
//    
//    @ObservedObject var stockViewModel: StockDetailsViewModel
//    
//    var body: some View {
//        Text("Hourly Chart Content")
//            .frame(width: 200, height: 200) // Explicit frame size
//            .background(Color.blue) // Background color for debugging
//    }
//}
//
//#Preview {
//    StockMainChartHourlyView()
//}
////
//
//import SwiftUI
//import WebKit
//
//struct StockMainChartHourlyView: View {
//    @ObservedObject var stockViewModel: StockDetailsViewModel
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
//            stockViewModel.loadStockHourlyData(for: "AAPL") // Load hourly data for "AAPL" or any other specified ticker
//        }
//    }
//
//    private func generateChartHTML() -> String {
//        let stockHourlyPriceData = stockViewModel.stockHourlyPriceData.map { "[\($0.timestamp * 1000), \($0.price)]" }.joined(separator: ",")
//        
//        let changeColor = (stockViewModel.percentageChange ?? 0) < 0 ? "#FF0000" : "#00FF00"
// // Assuming `percentageChange` is a computed property in `StockDetailsViewModel`
//
//        let chartOptions = """
//            {
//                chart: {
//                    backgroundColor: '#f5f5f5'
//                },
//                title: {
//                    text: 'AAPL Hourly Price Variation',
//                    style: {
//                        color: '#767676',
//                    }
//                },
//                navigator: {
//                    enabled: false
//                },
//                rangeSelector: {
//                    enabled: false
//                },
//                xAxis: {
//                    type: 'datetime',
//                    endOnTick: false,
//                    startOnTick: false,
//                    dateTimeLabelFormats: {
//                        minute: '%H:%M',
//                    }
//                },
//                yAxis: {
//                    opposite: true,
//                    labels: {
//                        align: 'left',
//                        x: -15,
//                        y: 0,
//                    }
//                },
//                plotOptions: {
//                    spline: {
//                        color: '\(changeColor)',
//                        tooltip: {
//                            valueDecimals: 2,
//                        },
//                    },
//                },
//                series: [{
//                    type: 'spline',
//                    data: [\(stockHourlyPriceData)],
//                    name: 'AAPL Stock Price',
//                    tooltip: {
//                        valueDecimals: 2,
//                    },
//                    pointPlacement: 'on',
//                }]
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
//import SwiftUI
//
//struct StockMainChartHourlyView: View {
//    @ObservedObject var viewModel: StockDetailsViewModel
//    let symbol: String
//    
//    var body: some View {
//        VStack {
//            if viewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let errorMessage = viewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//            } else {
//                WebView(htmlContent: generateChartHTML())
//                    .frame(maxWidth: .infinity, maxHeight: 400)
//            }
//        }
//        .onAppear {
//            viewModel.loadStockHourlyData(for: "AAPL")
//        }
//    }
//    
//    private func generateChartHTML() -> String {
//        let priceData = viewModel.stockHourlyPriceData.map { "[\($0[0]), \($0[1])]" }.joined(separator: ",")
//        let volumeData = viewModel.hourlyVolumeData.map { "[\($0.timestamp), \($0.volume)]" }.joined(separator: ",")
//
//        let changePercent = viewModel.percentageChange ?? 0.0  // Assuming this comes from your ViewModel
//
//        let chartOptions = """
//            {
//                chart: {},
//                title: {
//                    text: '\(symbol) Hourly Price Variation',
//                    style: {
//                        color: '#767676',
//                    },
//                },
//                navigator: {
//                    enabled: false,
//                },
//                rangeSelector: {
//                    enabled: false,
//                },
//                xAxis: {
//                    type: 'datetime',
//                    endOnTick: false,
//                    startOnTick: false,
//                    dateTimeLabelFormats: {
//                        minute: '%H:%M',
//                    },
//                },
//                yAxis: {
//                    opposite: true,
//                    labels: {
//                        align: 'left',
//                        x: -15,
//                        y: 0,
//                    },
//                },
//                plotOptions: {
//                    spline: {
//                        color: \(changePercent < 0 ? "'#FF0000'" : "'#00FF00'"),
//                        tooltip: {
//                            valueDecimals: 2,
//                        },
//                    },
//                },
//                series: [
//                    {
//                        type: 'spline',
//                        data: [\(priceData)],
//                        name: '\(symbol) Stock Price',
//                        tooltip: {
//                            valueDecimals: 2,
//                        },
//                        pointPlacement: 'on',
//                    },
//                    {
//                        type: 'column',
//                        data: [\(volumeData)],
//                        name: 'Volume',
//                        yAxis: 1,
//                        tooltip: {
//                            valueDecimals: 0,
//                        }
//                    }
//                ]
//            }
//        """
//
//        let html = """
//            <html>
//            <head>
//                <meta name="viewport" content="initial-scale=1.0">
//                <script src="https://code.highcharts.com/stock/highstock.js"></script>
//                <script src="https://code.highcharts.com/modules/exporting.js"></script>
//                <style>
//                    body { margin: 0; height: 100%; display: flex; justify-content: center; align-items: center; }
//                    #container { height: 100%; width: 100%; }
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
//import SwiftUI
//import WebKit
//
//struct StockMainChartHourlyView: View {
//    @ObservedObject var stockViewModel: StockDetailsViewModel
//    var ticker: String
//    var changePercent: Double  // Now accepts changePercent directly
//
//    var body: some View {
//        VStack {
//            if stockViewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let errorMessage = stockViewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//            } else if let data = stockViewModel.hourlyChartData {
//                WebView(htmlContent: generateChartHTML(data: data))
//                    .frame(maxWidth: .infinity, maxHeight: 400)
//            } else {
//                Text("No data available")
//            }
//        }
//        .onAppear {
//            // Output the changePercent for debugging purposes
//            print("Loaded with changePercent: \(changePercent)")
//            stockViewModel.loadStockHourlyData(for: ticker)
//        }
//    }
//
//    private func generateChartHTML(data: HourlyChartData) -> String {
//        let priceData = data.stockPricePoints.map { "[\($0.timestamp), \($0.price)]" }.joined(separator: ",")
//        
//        // Use the directly passed changePercent for real-time accuracy
//        let chartOptions = """
//            {
//                chart: {},
//                title: {
//                    text: '\(ticker) Hourly Price Variation',
//                    style: {
//                        color: '#767676',
//                    },
//                },
//                navigator: {
//                    enabled: false,
//                },
//                rangeSelector: {
//                    enabled: false,
//                },
//                xAxis: {
//                    type: 'datetime',
//                    endOnTick: false,
//                    startOnTick: false,
//                    dateTimeLabelFormats: {
//                        minute: '%H:%M',
//                    },
//                },
//                yAxis: {
//                    opposite: true,
//                    labels: {
//                        align: 'left',
//                        x: -15,
//                        y: 0,
//                    },
//                },
//                plotOptions: {
//                    spline: {
//                        color: \(changePercent < 0 ? "'#FF0000'" : "'#00FF00'"),
//                        tooltip: {
//                            valueDecimals: 2,
//                        },
//                    },
//                },
//                series: [{
//                    type: 'spline',
//                    data: [\(priceData)],
//                    name: '\(ticker) Stock Price',
//                    tooltip: {
//                        valueDecimals: 2,
//                    },
//                    pointPlacement: 'on',
//                }]
//            }
//        
//"""
//
//    let html = """
//            <html>
//            <head>
//                <meta name="viewport" content="initial-scale=1.0">
//                <script src="https://code.highcharts.com/stock/highstock.js"></script>
//                <script src="https://code.highcharts.com/modules/exporting.js"></script>
//                <style>
//                    body { margin: 0; height: 100%; display: flex; justify-content: center; align-items: center; }
//                    #container { height: 100%; width: 100%; }
//                </style>
//            </head>
//            <body>
//                <div id="container"></div>
//                <script>
//                    Highcharts.stockChart('container', \(chartOptions));
//                </script>
//            </body>
//            </html>
//        
//"""
//
//    return html
//}
//}


import SwiftUI
import WebKit

struct StockMainChartHourlyView: View {
    @ObservedObject var stockViewModel: StockDetailsViewModel
    var ticker: String
    var changePercent: Double  // Now accepts changePercent directly

    var body: some View {
        VStack {
            if stockViewModel.isLoading {
                ProgressView("Loading...")
            } 
//            else if let errorMessage = stockViewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//            } 
        else if let data = stockViewModel.hourlyChartData {
                WebView(htmlContent: generateChartHTML(data: data))
                    .frame(maxWidth: .infinity, maxHeight: 400)
            } 
//            else {
//                Text("No data available")
//            }
        }
        .onAppear {
            // Output the changePercent for debugging purposes
            print("Loaded with changePercent: \(changePercent)")
            stockViewModel.loadStockHourlyData(for: ticker)
        }
    }

    private func generateChartHTML(data: HourlyChartData) -> String {
        let priceData = data.stockPricePoints.map { "[\($0.timestamp), \($0.price)]" }.joined(separator: ",")
        
        // Use the directly passed changePercent for real-time accuracy
        let chartOptions = """
            {
                chart: {},
                title: {
                    text: '\(ticker) Hourly Price Variation',
                    style: {
                        color: '#767676',
                    },
                },
                navigator: {
                    enabled: false,
                },
                rangeSelector: {
                    enabled: false,
                },
                xAxis: {
                    type: 'datetime',
                    endOnTick: false,
                    startOnTick: false,
                    dateTimeLabelFormats: {
                        minute: '%H:%M',
                    },
                },
                yAxis: {
                    opposite: true,
                    labels: {
                        align: 'left',
                        x: -15,
                        y: 0,
                    },
                },
                plotOptions: {
                    spline: {
                        color: \(changePercent < 0 ? "'#FF0000'" : "'#00FF00'"),
                        tooltip: {
                            valueDecimals: 2,
                        },
                    },
                },
                series: [{
                    type: 'spline',
                    data: [\(priceData)],
                    name: '\(ticker)',
                    tooltip: {
                        valueDecimals: 2,
                    },
                    pointPlacement: 'on',
                }]
            }
        """

        let html = """
            <html>
            <head>
                <meta name="viewport" content="initial-scale=1.0">
                <script src="https://code.highcharts.com/stock/highstock.js"></script>
                <script src="https://code.highcharts.com/modules/exporting.js"></script>
                <style>
                    body { margin: 0; height: 100%; display: flex; justify-content: center; align-items: center; }
                    #container { height: 100%; width: 100%; }
                </style>
            </head>
            <body>
                <div id="container"></div>
                <script>
                    Highcharts.stockChart('container', \(chartOptions));
                </script>
            </body>
            </html>
        """

        return html
    }
}
