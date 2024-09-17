//
//  FavoritesView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/8/24.
//

//if no change, grey it out


import SwiftUI

//struct FavoritesView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    FavoritesView()
//}

//struct FavoritesView: View {
//    let favoriteStocks: [FavoriteStock]
//
//    var body: some View {
//        Section(header: Text("FAVORITES")) {
//            ForEach(favoriteStocks, id: \.symbol) { stock in
//                NavigationLink(destination: StockDetailsView(symbol: stock.symbol)) {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(stock.symbol).font(.title2).bold()
//                            Text(stock.companyName)
//                                .font(.headline)
//                                .fontWeight(.regular)
//                                .foregroundColor(.secondary)
//                        }
//                        Spacer()
//                        VStack(alignment: .trailing) {
//                            Text("$\(stock.currentPrice, specifier: "%.2f")")
//                                .fontWeight(.bold)
//                            HStack {
//                                Image(systemName: stock.change >= 0 ? "arrow.up.forward" : "arrow.down.forward")
//                                    .foregroundColor(stock.change >= 0 ? .green : .red)
//                                Text("$\(stock.change, specifier: "%.2f")")
//                                    .foregroundColor(stock.change >= 0 ? .green : .red)
//                                Text("(\(stock.changePercentage, specifier: "%.2f")%)")
//                                    .foregroundColor(stock.change >= 0 ? .green : .red)
//                            }
//                            .fixedSize(horizontal: true, vertical: false)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}

struct FavoritesView: View {
    @ObservedObject var viewModel: WatchlistViewModel
    
    var body: some View {
        Section(header: Text("FAVORITES")) {
//            if viewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage).foregroundColor(.red)
//            } else {

                ForEach(viewModel.favoriteStocks) { stock in
                    NavigationLink(destination: StockDetailsView(symbol: stock.symbol)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(stock.symbol).font(.title2).bold()
                                Text(stock.companyName)
                                    .font(.headline)
                                    .fontWeight(.regular)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                if let currentPrice = stock.currentPrice {
                                    Text("$\(currentPrice, specifier: "%.2f")")
                                        .fontWeight(.bold)
                                }
                                HStack {
                                    if let change = stock.change {
                                        Image(systemName: change >= 0 ? "arrow.up.forward" : "arrow.down.forward")
                                            .foregroundColor(change >= 0 ? .green : .red)
                                        Text("$\(change, specifier: "%.2f")")
                                            .foregroundColor(change >= 0 ? .green : .red)
                                        if let changePercentage = stock.changePercentage {
                                            Text("(\(changePercentage, specifier: "%.2f")%)")
                                                .foregroundColor(change >= 0 ? .green : .red)
                                        }
                                    }
                                }
                                .fixedSize(horizontal: true, vertical: false)
                            }
                        }
                        
                    }
                    
                }
                .onDelete(perform: viewModel.deleteFavorites(at:))
                .onMove(perform: viewModel.moveFavorites)
//            }
            
        }
        .onAppear {
            viewModel.loadFavorites() // Calling loadFavorites when the view appears
            viewModel.refreshFavorites()
        }
        
    }
}


