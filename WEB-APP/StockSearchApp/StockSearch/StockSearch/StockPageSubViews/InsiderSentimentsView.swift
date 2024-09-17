//
//  InsiderSentimentsView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//

import SwiftUI

//struct InsiderSentimentsView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    InsiderSentimentsView()
//}

import SwiftUI

struct InsiderSentimentsView: View {
    var sentiments: [InsiderSentiment]
    var companyName: String

    private var totalChange: Double {
        Double(sentiments.reduce(0) { $0 + $1.change })
        }

        private var totalMspr: Double {
            sentiments.reduce(0) { $0 + $1.mspr }
        }

        private var positiveChange: Double {
            Double(sentiments.filter { $0.change > 0 }.reduce(0) { $0 + $1.change })
        }

        private var negativeChange: Double {
            Double(sentiments.filter { $0.change < 0 }.reduce(0) { $0 + $1.change })
        }

        private var positiveMspr: Double {
            sentiments.filter { $0.mspr > 0 }.reduce(0) { $0 + $1.mspr }
        }

        private var negativeMspr: Double {
            sentiments.filter { $0.mspr < 0 }.reduce(0) { $0 + $1.mspr }
        }


    var body: some View {
        Text("Insights").font(.title2)
        VStack() {
            Text("Insider Sentiments")
                .font(.title2)
                .padding(.bottom)

            HStack {
                VStack(alignment: .leading) {
                    Text("\(companyName)")
                        .bold()
                    Divider()
                    Text("Total")
                        .bold()
                    Divider()
                    Text("Positive")
                        .bold()
                    Divider()
                    Text("Negative")
                        .bold()
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("MSPR")
                        .bold()
                    Divider()
                    Text(String(format: "%.2f", totalMspr))
                    Divider()
                    Text(String(format: "%.2f", positiveMspr))  // Using positiveChange for mspr as a placeholder
                    Divider()
                    Text(String(format: "%.2f", negativeMspr))  // Using negativeChange for mspr as a placeholder
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Change")
                        .bold()
                    Divider()
                    Text(String(format: "%.2f", totalChange))
                    Divider()
                    Text(String(format: "%.2f", positiveChange))
                    Divider()
                    Text(String(format: "%.2f", negativeChange))
                    Divider()
                }
            }

        }
    }
}

struct SentimentRow: View {
    var title: String
    var mspr: Double
    var change: Double

    var body: some View {
        HStack {
            Text(title)
                .bold()
            Spacer()
            Text(String(format: "%.2f", mspr))
            Spacer()
            Text(String(format: "%.2f", change))
        }
    }
}
