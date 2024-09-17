//
//  StockMainChartHistoricalView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 5/1/24.
//
//import SwiftUI
//
//struct StockMainChartHistoricalView: View {
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
//            stockViewModel.loadStockPriceData(for: "AAPL") // Assume "AAPL" or any other ticker
//        }
//    }
//
//    private func generateChartHTML() -> String {
//            let stockPriceData = stockViewModel.stockPriceData.map { "[\($0.timestamp), \($0.price), \($0.price), \($0.price), \($0.price)]" }.joined(separator: ",")
//            let volumeData = stockViewModel.volumeData.map { "[\($0.timestamp), \($0.volume)]" }.joined(separator: ",")
//
//            let chartOptions = """
//                {
//                    chart: {
//                        type: 'stockChart'
//                    },
//                    rangeSelector: {
//                        selected: 2
//                    },
//                    title: {
//                        text: 'AAPL Historical'
//                    },
//                    subtitle: {
//                        text: 'With SMA and Volume by Price technical indicators'
//                    },
//                    series: [{
//                        type: 'candlestick',
//                        name: 'AAPL',
//                        id: 'AAPL',
//                        data: [\(stockPriceData)]
//                    }, {
//                        type: 'column',
//                        name: 'Volume',
//                        id: 'volume',
//                        data: [\(volumeData)],
//                        yAxis: 1
//                    }, {
//                        type: 'vbp',
//                        linkedTo: 'AAPL',
//                        params: {
//                            volumeSeriesID: 'volume'
//                        },
//                        dataLabels: {
//                            enabled: false
//                        },
//                        zoneLines: {
//                            enabled: false
//                        }
//                    }, {
//                        type: 'sma',
//                        linkedTo: 'AAPL',
//                        zIndex: 1,
//                        marker: {
//                            enabled: false
//                        }
//                    }],
//                    yAxis: [
//                        {
//                            startOnTick: false,
//                            endOnTick: false,
//                            labels: {
//                                align: 'right',
//                                x: -3,
//                            },
//                            title: {
//                                text: 'OHLC'
//                            },
//                            height: '60%',
//                            lineWidth: 2,
//                            resize: {
//                                enabled: true
//                            },
//                        }, {
//                            labels: {
//                                align: 'right',
//                                x: -3,
//                            },
//                            title: {
//                                text: 'Volume'
//                            },
//                            top: '65%',
//                            height: '35%',
//                            offset: 0,
//                            lineWidth: 2,
//                        }
//                    ],
//                    tooltip: {
//                        split: true,
//                    }
//                }
//            """
//
//            let html = """
//                <html>
//                <head>
//                    <meta name="viewport" content="width=device-width, initial-scale=0.85">
//                    <script src="https://code.highcharts.com/stock/highstock.js"></script>
//                    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
//                    <script src="https://code.highcharts.com/stock/indicators/indicators.js"></script>
//                    <script src="https://code.highcharts.com/stock/indicators/volume-by-price.js"></script>
//                    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
//                    <style>
//                        body { margin: 0; display: flex; justify-content: center; align-items: center; }
//                        #container { height: 90%; width: 100% }
//                    </style>
//                </head>
//                <body>
//                    <div id="container"></div>
//                    <script>
//                        Highcharts.stockChart('container', \(chartOptions));
//                    </script>
//                </body>
//                </html>
//            """
//
//            return html
//        }
//}


//#Preview {
//    StockMainChartHistoricalView()
//}


//import SwiftUI
//import WebKit
//
//struct StockMainChartHistoricalView: View {
//    @ObservedObject var stockViewModel: StockDetailsViewModel
//    var ticker: String  // Adding a ticker property
//    
//    var body: some View {
//        VStack {
//            if stockViewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let errorMessage = stockViewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//            } else {
//                WebView(htmlContent: generateChartHTML())
//                                            .frame(maxWidth: .infinity, maxHeight: 400)
//            }
//        }
//                .onAppear {
//            // Use the provided ticker instead of hardcoding
//            stockViewModel.loadStockPriceData(for: ticker)
//        }
//    }
//    
//    private func generateChartHTML() -> String {
//        let stockPriceData = stockViewModel.stockPriceData.map { "[\($0.timestamp), \($0.price), \($0.price), \($0.price), \($0.price)]" }.joined(separator: ",")
//        let volumeData = stockViewModel.volumeData.map { "[\($0.timestamp), \($0.volume)]" }.joined(separator: ",")
//        
//        let chartOptions = """
//            {
//                chart: {
//                    type: 'stockChart'
//                },
//                rangeSelector: {
//                    selected: 2
//                },
//                title: {
//                    text: '\(ticker) Historical'
//                },
//                subtitle: {
//                    text: 'With SMA and Volume by Price technical indicators'
//                },
//                series: [{
//                    type: 'candlestick',
//                    name: '\(ticker)',
//                    id: '\(ticker)',
//                    data: [\(stockPriceData)]
//                }, {
//                    type: 'column',
//                    name: 'Volume',
//                    id: 'volume',
//                    data: [\(volumeData)],
//                    yAxis: 1
//                }, {
//                    type: 'vbp',
//                    linkedTo: '\(ticker)',
//                    params: {
//                        volumeSeriesID: 'volume'
//                    },
//                    dataLabels: {
//                        enabled: false
//                    },
//                    zoneLines: {
//                        enabled: false
//                    }
//                }, {
//                    type: 'sma',
//                    linkedTo: '\(ticker)',
//                    zIndex: 1,
//                    marker: {
//                        enabled: false
//                    }
//                }],
//                yAxis: [
//                    {
//                        startOnTick: false,
//                        endOnTick: false,
//                        labels: {
//                            align: 'right',
//                            x: -3,
//                        },
//                        title: {
//                            text: 'OHLC'
//                        },
//                        height: '60%',
//                        lineWidth: 2,
//                        resize: {
//                            enabled: true
//                        },
//                    }, {
//                        labels: {
//                            align: 'right',
//                            x: -3,
//                        },
//                        title: {
//                            text: 'Volume'
//                        },
//                        top: '65%',
//                        height: '35%',
//                        offset: 0,
//                        lineWidth: 2,
//                    }
//                ],
//                tooltip: {
//                    split: true,
//                }
//            }
//        
//"""
//        
//        let html = """
//            <html>
//            <head>
//                <meta name="viewport" content="width=device-width, initial-scale=0.85">
//                <script src="https://code.highcharts.com/stock/highstock.js"></script>
//                <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
//                <script src="https://code.highcharts.com/stock/indicators/indicators.js"></script>
//                <script src="https://code.highcharts.com/stock/indicators/volume-by-price.js"></script>
//                <script src="https://code.highcharts.com/modules/accessibility.js"></script>
//                <style>
//                    body { margin: 0; display: flex; justify-content: center; align-items: center; }
//                    #container { height: 90%; width: 100% }
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
//        return html
//    }
//}

//#Preview {
//    StockMainChartHistoricalView(ticker: "AAPL")
//}


import SwiftUI
import WebKit

struct StockMainChartHistoricalView: View {
    @ObservedObject var stockViewModel: StockDetailsViewModel
    var ticker: String  // Adding a ticker property

    var body: some View {
        VStack {
            if stockViewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = stockViewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                WebView(htmlContent: generateChartHTML())
                    .frame(maxWidth: .infinity, maxHeight: 400)
            }
        }
        .onAppear {
            // Use the provided ticker instead of hardcoding
            stockViewModel.loadStockPriceData(for: ticker)
        }
    }

    private func generateChartHTML() -> String {
        let stockPriceData = stockViewModel.stockPriceData.map { "[\($0.timestamp), \($0.price), \($0.price), \($0.price), \($0.price)]" }.joined(separator: ",")
        let volumeData = stockViewModel.volumeData.map { "[\($0.timestamp), \($0.volume)]" }.joined(separator: ",")

        let chartOptions = """
                {
                chart: {
                    type: 'stockChart'
                },
                rangeSelector: {
                    selected: 2
                },
                title: {
                    text: '\(ticker) Historical'
                },
                subtitle: {
                    text: 'With SMA and Volume by Price technical indicators'
                },
                series: [{
                    type: 'candlestick',
                    name: '\(ticker)',
                    id: '\(ticker)',
                    data: [\(stockPriceData)],
                    zIndex: 2,
                    marker: {
                            enabled: false
                        }
                }, {
                    type: 'column',
                    name: 'Volume',
                    id: 'volume',
                    data: [\(volumeData)],
                    yAxis: 1
                }, {
                    type: 'vbp',
                    linkedTo: '\(ticker)',
                    params: {
                        volumeSeriesID: 'volume'
                    },
                    dataLabels: {
                        enabled: false
                    },
                    zoneLines: {
                        enabled: false
                    }
                }, {
                    type: 'sma',
                    linkedTo: '\(ticker)',
                    zIndex: 1,
                    marker: {
                        enabled: false
                    }
                }],
                         yAxis: [
                                {
                                  startOnTick: false,
                                  endOnTick: false,
                                  labels: {
                                    align: 'right',
                                    x: -3,
                                  },
                                  title: {
                                    text: 'OHLC',
                                  },
                                  height: '60%',
                                  lineWidth: 2,
                                  resize: {
                                    enabled: true,
                                  },
                                },
                                {
                                  labels: {
                                    align: 'right',
                                    x: -3,
                                  },
                                  title: {
                                    text: 'Volume',
                                  },
                                  top: '65%',
                                  height: '35%',
                                  offset: 0,
                                  lineWidth: 2,
                                },
                              ],
                              tooltip: {
                                split: true,
                              }
                    }
                """

                let html = """
                    <html>
                    <head>
                        <meta name="viewport" content="width=device-width, initial-scale=0.85">
                        <script src="https://code.highcharts.com/stock/highstock.js"></script>
                        <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
                        <script src="https://code.highcharts.com/stock/indicators/indicators.js"></script>
                        <script src="https://code.highcharts.com/stock/indicators/volume-by-price.js"></script>
                        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
                        <style>
                            body { margin: 0; display: flex; justify-content: center; align-items: center; }
                            #container { height: 90%; width: 100% }
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
