//
//  EPSSurprisesView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//
//
//import SwiftUI
//
//struct EPSSurprisesView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    EPSSurprisesView()
//}


//import SwiftUI
//import WebKit
//
//struct EPSSurprisesView: View {
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
//            Spacer()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//    }
//
//    private func generateChartHTML() -> String {
//        let actualData = viewModel.earnings.map { $0.actual }
//        let estimateData = viewModel.earnings.map { $0.estimate }
//        let periods = viewModel.earnings.map { "\"\($0.period)\"" }
//        let surprises = viewModel.earnings.map { $0.surprise }
//        
//                let categories = viewModel.earnings.map { "\($0.period) <br />Surprise: \($0.surprise)" }
//                let joinedCategories = categories.joined(separator: "\",\"")
//
//        print(actualData)
//        
//        let chartOptions = """
//        {
//            chart: { type: 'spline', backgroundColor: 'white' },
//            title: { text: 'Historical EPS Surprises' },
//            xAxis: {
//        labels: {
//                                    
//                                    rotation: -45,
//                                },
//                categories: ["\(joinedCategories)"]
//            },
//            yAxis: {
//                title: { text: 'Quarterly EPS' },
//                tickInterval: 0.25
//            },
//            series: [
//                { name: 'Actual EPS', data: \(viewModel.earnings.map { $0.actual }), type: 'spline' },
//                { name: 'Estimated EPS', data: \(viewModel.earnings.map { $0.estimate }), type: 'spline'},
//            ],
//            tooltip: {
//            },
//            plotOptions: {
//                series: {
//                    label: { connectorAllowed: false }
//                }
//            },
//        legend: {
//                                       itemStyle: {
//                                           
//                                       }
//                                           },
//        }
//        """
//        let html = """
//        <html>
//        <head>
//        <meta name="viewport" content="width=device-width, initial-scale=1">
//        <script src="https://code.highcharts.com/highcharts.js"></script>
//        <script src="https://code.highcharts.com/modules/exporting.js"></script>
//        <script src="https://code.highcharts.com/modules/export-data.js"></script>
//        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
//        <style>
//            body { margin: 0; height: 100%; display: flex; justify-content: center; align-items: center; }
//            #container { height: 100%; width: 100%; }
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
//
//// Supporting WebView to render HTML content
//struct WebView: UIViewRepresentable {
//    let htmlContent: String
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.loadHTMLString(htmlContent, baseURL: nil)
//    }
//}

//
//
//import SwiftUI
//import WebKit
//
//struct EPSSurprisesView: View {
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
////                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
//            }
////            Spacer()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//        .padding(0.0)
//    }
//        
//    
//    private func generateChartHTML() -> String {
//        let actualData = viewModel.earnings.map { $0.actual }
//        let estimateData = viewModel.earnings.map { $0.estimate }
//        let periods = viewModel.earnings.map { "\"\($0.period)\"" }
//        let surprises = viewModel.earnings.map { $0.surprise }
//        
//        let categories = viewModel.earnings.map { "\($0.period) <br />Surprise: \($0.surprise)" }
//        let joinedCategories = categories.joined(separator: "\",\"")
//        
//        let chartOptions = """
//        {
//                    chart: { type: 'spline', backgroundColor: 'white'},
//                    navigation: {
//                            buttonOptions: {
//                                enabled: true,
//                                
//                            }
//                        },
//                    title: { text: 'Historical EPS Surprises'},
//                    xAxis: {
//                                labels: {
//                                    
//                                    rotation: -45,
//                                },
//                    categories: ["\(joinedCategories)"]
//                    },
//                    yAxis: {
//                        title: { text: 'Quarterly EPS' },
//                                    tickInterval: 0.25
//                            },
//                    tooltip: {
//                        style: {
//                              
//                      }},
//                    plotOptions: {
//                
//                        series: {
//                            label: { connectorAllowed: false }
//                
//                        }
//                    },
//                           legend: {
//                                       itemStyle: {
//                                           
//                                       }
//                                           },
//                    series: [
//                        { name: 'Actual', data: \(viewModel.earnings.map { $0.actual }), type: 'spline' },
//                        { name: 'Estimate', data: \(viewModel.earnings.map { $0.estimate }), type: 'spline' }
//                    ]
//                }
//        """
//        let html = """
//            <html>
//            <head>
//            <meta name="viewport" content="width=device-width, initial-scale=0.85">
//            <script src="https://code.highcharts.com/highcharts.js"></script>
//            <script src="https://code.highcharts.com/modules/exporting.js"></script>
//            <style>
//                body {
//                        display: flex;
//                        justify-content: center;
//                        align-items: flex-start;
//    
//                    }
//                    #container {
//                        width: 100%;
//                        height: 90%;
//
//                    }
//            </style>
//            </head>
//            <body>
//            <div id="container"></div>
//            <script>
//            Highcharts.chart('container', \(chartOptions));
//            </script>
//            </body>
//            </html>
//            
//"""
//        return html
//    }
//}
//
//// Supporting WebView to render HTML content
//struct WebView: UIViewRepresentable {
//    let htmlContent: String
//    
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//    
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.loadHTMLString(htmlContent, baseURL: nil)
//    }
//}

import SwiftUI
import WebKit

struct EPSSurprisesView: View {
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
        .padding(0.0)
    }
    
    private func generateChartHTML() -> String {
        let actualData = viewModel.earnings.map { $0.actual }
        let estimateData = viewModel.earnings.map { $0.estimate }
        let periods = viewModel.earnings.map { "\"\($0.period)\"" }
        let surprises = viewModel.earnings.map { $0.surprise }
        
        let categories = viewModel.earnings.map { "\($0.period) <br />Surprise: \($0.surprise)" }
        let joinedCategories = categories.joined(separator: "\",\"")
        
        let chartOptions = """
        {
            chart: { type: 'spline' },
            title: { text: 'Historical EPS Surprises' },
             xAxis: {
                                            labels: {
                                                
                                                rotation: -45,
                                            },
                                categories: ["\(joinedCategories)"]
                                },
            yAxis: {
                title: { text: 'Quarterly EPS' }
            },
            plotOptions: {
                series: { label: { connectorAllowed: false } }
            },
            series: [
                { name: 'Actual', data: \(actualData), type: 'spline' },
                { name: 'Estimate', data: \(estimateData), type: 'spline' }
            ]
        }
        """

        let html = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=0.85">
            <script src="https://code.highcharts.com/highcharts.js"></script>
            <script src="https://code.highcharts.com/modules/exporting.js"></script>
            <style>
                body { display: flex; justify-content: center; align-items: flex-start; }
                #container { width: 100%; height: 90%; }
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

// Supporting WebView to render HTML content
struct WebView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
