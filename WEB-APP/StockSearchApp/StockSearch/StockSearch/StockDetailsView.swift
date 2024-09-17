//
//  StockDetailsView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//

//import SwiftUI
//
//struct StockDetailsView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//
//#Preview {
//    StockDetailsView()
//}


//import SwiftUI
//
//struct StockDetailsView: View {
//    let symbol: String
//    @State private var stockDetails: StockDetails?
//    @State private var isLoading = false
//    @State private var errorMessage: String?
//
//    var body: some View {
//        Group {
//            Text("hello")
//            if isLoading {
//                ProgressView()
//            } else if let stockDetails = stockDetails {
//                VStack {
//                    Text("Details for \(stockDetails.symbol)")
//                    Text("Current Price: $\(stockDetails.currentPrice, specifier: "%.2f")")
//                    Text("Previous Closing Price: $\(stockDetails.previousClosingPrice, specifier: "%.2f")")
//                    // ... display other details ...
//                }
//            } else if let errorMessage = errorMessage {
//                Text(errorMessage)
//            }
//        }
//        .navigationTitle(symbol)
//        .onAppear {
//            loadStockDetails()
//        }
//        .padding()
//    }
//
//    private func loadStockDetails() {
//        guard let url = URL(string: "http://localhost:3000/api/stock/summary?symbol=\(symbol)") else {
//            print("Invalid URL")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//
//                if let error = error {
//                    self.errorMessage = "Could not load details: \(error.localizedDescription)"
//                    return
//                }
//
//                guard let data = data else {
//                    self.errorMessage = "No data received"
//                    return
//                }
//
//                do {
//                    print("trying to get data")
//                    // Decode the JSON into the StockDetails structure
//                    let decodedDetails = try JSONDecoder().decode(StockDetails.self, from: data)
//                    print("decoded")
//                    self.stockDetails = decodedDetails
//                    print("hello")
//                    print(decodedDetails)
//                } catch {
//                    // If decoding fails, print the error message
//                    self.errorMessage = "Failed to decode response: \(error.localizedDescription)"
//                }
//
//            }
//        }
//
//        task.resume()
//    }
//
//
//
//
//}
//
//
//#Preview {
////    print("going to view")
//    StockDetailsView(symbol: "TSLA")
//}

//
//import SwiftUI
//
//struct StockDetailsView: View {
//    let symbol: String
//    @StateObject private var viewModel = StockDetailsViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                if viewModel.isLoading {
//                    Spacer()
//                    ProgressView("Fetching Data...")
//                } else if let stockDetails = viewModel.stockDetails, let companyDetails = viewModel.companyDetails{
//                    StockInfoView(
//                        symbol: stockDetails.symbol,
//                        companyName: companyDetails.name,
//                        currentPrice: stockDetails.currentPrice,
//                        priceChange: stockDetails.change,
//                        percentChange: stockDetails.changePercent
//                    )
//
//                    //                    Divider()
//
//
//                    StockStatsView(
//                        highPrice: stockDetails.highPrice,
//                        openPrice: stockDetails.openingPrice,
//                        lowPrice: stockDetails.lowPrice,
//                        prevClose: stockDetails.previousClosingPrice,
//                        ipoDate: companyDetails.ipo,
//                        industry: companyDetails.finnhubIndustry,
//                        webURL: URL(string: companyDetails.weburl)!,
////                        peers: ["AAPL", "DELL", "SMCI", "HPQ", "HPE"]  Example peers, replace with actual data
//                        peers: viewModel.peers
//                    )
//
////                    print(viewModel.newsArticles)
////                    if !viewModel.newsArticles.isEmpty {
//                        NewsView(articles: viewModel.newsArticles)
////                    }
//                } else if let errorMessage = viewModel.errorMessage {
//                    Text("Error: \(errorMessage)").foregroundColor(.red)
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("\(symbol)")
//        .navigationBarItems(trailing: Button(action: {
//                    // Define what happens when this button is tapped.
//                    print("Plus button tapped")
//                }) {
//                    Image(systemName: "plus.circle.fill")
//                })
//
//        .onAppear {
//            viewModel.loadAllData(for: symbol)
//        }
//
//    }
//}
//
//struct StockDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            StockDetailsView(symbol: "AAPL")
//        }
//    }
//}

import SwiftUI

struct StockDetailsView: View {
    let symbol: String
    @StateObject private var viewModel = StockDetailsViewModel()
    @EnvironmentObject private var portfolioViewModel: PortfolioViewModel
    @EnvironmentObject private var watchlistViewModel: WatchlistViewModel
    
    
    @State private var showToast = false
           @State private var toastMessage = ""

    
//    @StateObject private var portfolioViewModel = PortfolioViewModel()
    
//    private var portfolioStock: PortfolioStock? {
//        portfolioViewModel.stocks.first(where: { $0.symbol == symbol })
//    }
//    
    
    var body: some View {
        Group {
            if viewModel.isLoading || portfolioViewModel.isLoading || watchlistViewModel.isLoading{
                VStack {
                    Spacer()
                    ProgressView("Fetching Data...")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                contentScrollView
                
                    .navigationTitle("\(symbol)")
                    .navigationBarItems(trailing:
            //                                Button(action: {print("Plus button tapped")} ){
                                        Button(action: toggleWatchlist){
                                        
                                        
                        //            Image(systemName: "plus.circle.fill")
                        Image(systemName: viewModel.isInWatchlist ? "plus.circle.fill" : "plus.circle")
                    })
            }
        }

        .onAppear {
            viewModel.loadAllData(for: symbol)
            portfolioViewModel.loadPortfolioDetails()
        }
        .toast(isPresenting: $showToast, message: toastMessage)
    }
    
    private func toggleWatchlist() {
            if viewModel.isInWatchlist {
                // Remove from watchlist
                watchlistViewModel.removeFromWatchlist(symbol: symbol)
                toastMessage = "Removed \(symbol) from Favorites"

            } else {
                // Add to watchlist
                if let companyDetails = viewModel.companyDetails {
                    watchlistViewModel.addToWatchlist(symbol: symbol, name: companyDetails.name)
                    toastMessage = "Added \(symbol) to Favorites"

                }
            }
            // Update the isInWatchlist status
            viewModel.isInWatchlist.toggle()
            showToast = true
//        DispatchQueue.main.async {
                watchlistViewModel.refreshFavorites()
//            }

        }
    
    @ViewBuilder
    private var contentScrollView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20.0) {
                if let stockDetails = viewModel.stockDetails, let companyDetails = viewModel.companyDetails{
                    StockInfoView(
                        symbol: stockDetails.symbol,
                        companyName: companyDetails.name,
                        currentPrice: stockDetails.currentPrice,
                        priceChange: stockDetails.change,
                        percentChange: stockDetails.changePercent,
                        logo: companyDetails.logo
                    )
                    
                    
                    
                    
//                    StockMainChartView()
                    StockMainChartView(ticker: symbol)
                    
                    StockPortfolioView(symbol: stockDetails.symbol, companyName: companyDetails.name, currentPrice: stockDetails.currentPrice )
                    
                    
                   
                    
                   
                    
                    StockStatsView(
                        highPrice: stockDetails.highPrice,
                        openPrice: stockDetails.openingPrice,
                        lowPrice: stockDetails.lowPrice,
                        prevClose: stockDetails.previousClosingPrice,
                        ipoDate: companyDetails.ipo,
                        industry: companyDetails.finnhubIndustry,
                        webURL: URL(string: companyDetails.weburl)!,
                        peers: viewModel.peers
                    )
                    
                    InsiderSentimentsView(sentiments: viewModel.insiderSentiments, companyName: companyDetails.name)
                    
                    RecommendationTrendsView(viewModel: viewModel)
                    
                    EPSSurprisesView(viewModel: viewModel)

                    
                    NewsView(articles: viewModel.newsArticles)
                    
                    
                    
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)").foregroundColor(.red)
                }
            }
            .padding(.top, 0)
            .padding(.horizontal)
        }
    }
    
    
}


#Preview {
    NavigationView {
        
        let portfolioViewModel = PortfolioViewModel()
        let watchlistViewModel = WatchlistViewModel()
        StockDetailsView(symbol: "MSFT")
            .environmentObject(portfolioViewModel)
            .environmentObject(watchlistViewModel)
    }
}

