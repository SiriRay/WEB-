//
//  StockInfoView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//

import SwiftUI

struct StockInfoView: View {
    let symbol: String
    let companyName: String
    let currentPrice: Double
    let priceChange: Double
    let percentChange: Double
    let logo: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                //                VStack(alignment: .leading) {
                
                Text(companyName)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.leading, 0)
                
                Spacer()
                
                if !logo.isEmpty, let logoURL = URL(string: logo) {
                    AsyncImage(url: logoURL) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 0)
                            
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                //                }
            }
            .padding(.top, 0)
//            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            HStack (){
                Text("$\(currentPrice, specifier: "%.2f")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                //                Spacer()
                Image(systemName: priceChange >= 0 ? "arrow.up.right" : "arrow.down.right")
                    .foregroundColor(priceChange >= 0 ? .green : .red)
                Text("$\(priceChange, specifier: "%.2f") (\(percentChange, specifier: "%.2f")%)")
                    .font(.title2)
                    .foregroundColor(priceChange >= 0 ? .green : .red)
            }
        }
        .padding(.top, 0)
        //        .padding()
    }
}

