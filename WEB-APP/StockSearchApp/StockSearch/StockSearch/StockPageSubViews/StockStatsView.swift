//
//  StockStatsView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//

import SwiftUI

struct StockStatsView: View {
    let highPrice: Double
    let openPrice: Double
    let lowPrice: Double
    let prevClose: Double
    let ipoDate: String
    let industry: String
    let webURL: URL
    let peers: [String] // Assuming you have peer symbols as an array

    var body: some View {
        VStack(alignment: .leading) {
            Text("Stats").font(.title2).padding(.bottom)
            HStack {
                VStack(alignment: .leading) {
                    HStack{
                        Text("High Price: ").bold() + Text("$\(highPrice, specifier: "%.2f")")
                    }
                    .padding(.bottom)
                    
                    HStack{
                        Text("Low Price: ").bold() + Text("$\(lowPrice, specifier: "%.2f")")
                    }
                    .padding(.bottom)
                    
              
                }
                .padding(.trailing)
//                Spacer()
                VStack(alignment: .leading) {
                    HStack{
                        Text("Open Price: ").bold() + Text("$\(openPrice, specifier: "%.2f")")
                    }
                    .padding(.bottom)
                    HStack{
                        Text("Prev. Close: ").bold() + Text("$\(prevClose, specifier: "%.2f")")
                    }
                    
                }
                .padding(.bottom)
            }
            .font(.caption)

            
            
            Text("About").font(.title2).padding(.bottom)
            HStack {
                    // VStack for labels
                    VStack(alignment: .leading, spacing: 8) {
                        Text("IPO Start Date:")
                            .bold()
                        Text("Industry:")
                            .bold()
                        Text("Webpage:")
                            .bold()
                        Text("Company Peers:")
                            .bold()
                    }
                Spacer()

                    // VStack for values
                VStack(alignment: .leading, spacing: 8.0) {
                        Text(ipoDate)
                        Text(industry)
                        Link(webURL.absoluteString, destination: webURL)
//                        Text(peers.joined(separator: ", ")) // Need to add links here
                    ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(peers, id: \.self) { peer in
                                            NavigationLink(destination: StockDetailsView(symbol: peer)) {
                                                Text(peer) + Text(",")
                                            }
//                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                }
//                .padding(.leading)
                }
            .font(.caption)

        }
        .padding([.top, .bottom, .trailing])
    }
}

//
//#Preview {
//    StockStatsView()
//}
