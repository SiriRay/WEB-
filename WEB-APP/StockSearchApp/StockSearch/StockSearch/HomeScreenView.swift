//
//  HomeScreenView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//
//
//import SwiftUI
//
//
//struct HomeScreenView: View {
//    
//    let currentDate = Date()
//    
//    let cashBalance: Double = 25000.00
//
//    
//    
//    
//    
//    @State private var searchText: String = ""
//    @StateObject private var viewModel = WatchlistViewModel()
//    @StateObject private var portfolioViewModel = PortfolioViewModel()
//    
//    // Timer to trigger updates every 15 seconds
//    let timer = Timer.publish(every: 100, on: .main, in: .common).autoconnect()
//    
//    
//    
//    var body: some View {
////        if portfolioViewModel.isLoading || viewModel.isLoading {
////                        // Display a loading spinner if either view model is loading data
////                            ProgressView("Fetching Data...")
//////            Text("Fetching Data")
////                    }
////        else{
//            NavigationView{
//                
//                
//                List {
//                    
//                    
//                    // Date
//                    Text(currentDateFormatted)
//                        .font(.title .bold())
//                        .foregroundStyle(.secondary)
//                        .padding(5)
//                    
//                    
//                    // Portfolio Section
//                    
//                    
//                    PortfolioView(netWorth: netWorth(),
//                                  cashBalance: portfolioViewModel.balance, portfolioViewModel: portfolioViewModel)
//                    
//                    
//                    // Favorites Section
//                    FavoritesView(viewModel: viewModel)
//                    
//                    
//                    HStack {
//                        Spacer()
//                        Link("Powered by Finhub.io", destination: URL(string: "https://finhub.io/")!)
//                            .font(.footnote)
//                            .foregroundColor(.secondary)
//                        Spacer()
//                    }
//                    
//                    
//                    
//                }
//                
//                
//                
//                .navigationTitle("Stocks")
//                .toolbar{
//                    EditButton()
//                }
//                .onReceive(timer) { _ in
//                    viewModel.refreshFavorites()  // Refresh Watchlist data
//                    portfolioViewModel.refreshPortfolio()  // Refresh Portfolio data
//                    
//                }
//                //            .onAppear {
//                //                viewModel.loadFavorites() // Calling loadFavorites when the view appears
//                //            }
//                
//            }
//        
//        .searchable(text: $searchText, prompt: "Search")
//        .environmentObject(portfolioViewModel)
////        }
//    }
//    
//    
//    private var currentDateFormatted: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: currentDate)
//    }
//    
//    private func netWorth() -> Double {
//            // Sum of all stock market values plus cash balance
//            let totalStockValue = portfolioViewModel.stocks.reduce(0) { $0 + $1.marketValue }
//            return totalStockValue + portfolioViewModel.balance
//        }
//}
//
//
//
//
//
//#Preview {
//    HomeScreenView()
//    
//}
//
//

// This works but without search bar
//import SwiftUI
//
//struct HomeScreenView: View {
//    let currentDate = Date()
//    let cashBalance: Double = 25000.00
//    
//    @State private var searchText: String = ""
//    @StateObject private var watchlistViewModel = WatchlistViewModel()
//    @StateObject private var portfolioViewModel = PortfolioViewModel()
//    @StateObject private var autoCompleteViewModel = AutoCompleteViewModel()
//    
//    @State private var searchCancellable: DispatchWorkItem?
//    
//    // Timer to trigger updates every 100 seconds
//    let timer = Timer.publish(every: 100, on: .main, in: .common).autoconnect()
//    
//    var body: some View {
//        NavigationView {
//            if searchText.isEmpty {
//                List {
//                    Text(currentDateFormatted)
//                        .font(.title.bold())
//                        .foregroundStyle(.secondary)
//                        .padding(5)
//                    
//                    PortfolioView(netWorth: netWorth(),
//                                  cashBalance: portfolioViewModel.balance, portfolioViewModel: portfolioViewModel)
//                    
//                    FavoritesView(viewModel: watchlistViewModel)
//                    
//                    HStack {
//                        Spacer()
//                        Link("Powered by Finhub.io", destination: URL(string: "https://finhub.io/")!)
//                            .font(.footnote)
//                            .foregroundColor(.secondary)
//                        Spacer()
//                    }
//                }
//                .navigationTitle("Stocks")
//                .toolbar {
//                    EditButton()
//                }
//                .onReceive(timer) { _ in
//                    watchlistViewModel.refreshFavorites()
//                    portfolioViewModel.refreshPortfolio()
//                }
//            } else {
//                List(autoCompleteViewModel.searchResults, id: \.symbol) { result in
//                    NavigationLink(destination: StockDetailsView(symbol: result.symbol).environmentObject(PortfolioViewModel())) {
//                        VStack(alignment: .leading) {
//                            Text(result.description)
//                                .fontWeight(.bold)
//                            Text(result.displaySymbol)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//                .navigationBarTitle("Search Stocks")
//            }
//        }
//        .searchable(text: $searchText)
//        .onChange(of: searchText) { _,newValue in
//            searchCancellable?.cancel()  // Cancel previous work item if it exists
//            let task = DispatchWorkItem {
//                self.autoCompleteViewModel.fetchAutoCompleteResults(query: newValue)
//            }
//            self.searchCancellable = task
//            // Execute task after 0.5 second delay
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
//        }
//        .environmentObject(portfolioViewModel)
//    }
//    
//    private var currentDateFormatted: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: currentDate)
//    }
//    
//    private func netWorth() -> Double {
//        let totalStockValue = portfolioViewModel.stocks.reduce(0) { $0 + $1.marketValue }
//        return totalStockValue + portfolioViewModel.balance
//    }
//}
//
//struct HomeScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreenView()
//    }
//}

//
//import SwiftUI
//
//struct HomeScreenView: View {
//    let currentDate = Date()
//    let cashBalance: Double = 25000.00
//
//    @State private var searchText: String = ""
//    @State private var isSearching = false
//    @FocusState private var isSearchFocused: Bool
//    
//    @StateObject private var watchlistViewModel = WatchlistViewModel()
//    @StateObject private var portfolioViewModel = PortfolioViewModel()
//    @StateObject private var autoCompleteViewModel = AutoCompleteViewModel()
//    
//    @State private var searchCancellable: DispatchWorkItem?
//    
//    let timer = Timer.publish(every: 100, on: .main, in: .common).autoconnect()
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                if searchText.isEmpty {
//                    mainContent
//                } else {
//                    searchResultsView
//                }
//            }
//            .navigationTitle("Stocks")
//            .toolbar {
//                if !isSearching {
//                    EditButton()
//                }
//            }
//            .searchable(text: $searchText, prompt: "Search")
//            .focused($isSearchFocused)
//            .onChange(of: searchText) { _,newValue in
//                isSearching = !newValue.isEmpty
//                performSearch(query: newValue)
//            }
//            .onSubmit(of: .search) {
//                isSearchFocused = false
//            }
//        }
//        .environmentObject(portfolioViewModel)
//        .environmentObject(watchlistViewModel)
//    }
//
//    var mainContent: some View {
//        List {
//            Text(currentDateFormatted)
//                .font(.title.bold())
//                .foregroundStyle(.secondary)
//                .padding(5)
//            
//            PortfolioView(netWorth: netWorth(),
//                          cashBalance: portfolioViewModel.balance, portfolioViewModel: portfolioViewModel)
//            
//            FavoritesView(viewModel: watchlistViewModel)
//            
//            HStack {
//                Spacer()
//                Link("Powered by Finhub.io", destination: URL(string: "https://finhub.io/")!)
//                    .font(.footnote)
//                    .foregroundColor(.secondary)
//                Spacer()
//            }
//        }
//        .onReceive(timer) { _ in
//            watchlistViewModel.refreshFavorites()
//            portfolioViewModel.refreshPortfolio()
//        }
//    }
//
//    var searchResultsView: some View {
//        List(autoCompleteViewModel.searchResults, id: \.symbol) { result in
//            NavigationLink(destination: StockDetailsView(symbol: result.symbol)
//                .environmentObject(portfolioViewModel)
//                .environmentObject(watchlistViewModel)
//            
//            ) {
//                VStack(alignment: .leading) {
//                    Text(result.description)
//                        .fontWeight(.bold)
//                    Text(result.displaySymbol)
//                        .foregroundColor(.gray)
//                }
//            }
//            .simultaneousGesture(TapGesture().onEnded {
//                isSearchFocused = false
//                searchText = ""
//            })
//        }
//        .navigationBarTitle("Stocks")
//    }
//
//    private func performSearch(query: String) {
//        
//        if query.isEmpty {
//                autoCompleteViewModel.clearResults()
//                return
//            }
//        searchCancellable?.cancel()
//        let task = DispatchWorkItem {
//            self.autoCompleteViewModel.fetchAutoCompleteResults(query: query)
//        }
//        searchCancellable = task
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
//    }
//    
//    private var currentDateFormatted: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: currentDate)
//    }
//    
//    private func netWorth() -> Double {
//        let totalStockValue = portfolioViewModel.stocks.reduce(0) { $0 + $1.marketValue }
//        return totalStockValue + portfolioViewModel.balance
//    }
//}
//
//struct HomeScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreenView()
//    }
//}
//
import SwiftUI

struct HomeScreenView: View {
    @State private var showSpinner = true
    
    let currentDate = Date()
    let cashBalance: Double = 25000.00

    @State private var searchText: String = ""
    @State private var isSearching = false
    @FocusState private var isSearchFocused: Bool
    
    @StateObject private var watchlistViewModel = WatchlistViewModel()
    @StateObject private var portfolioViewModel = PortfolioViewModel()
    @StateObject private var autoCompleteViewModel = AutoCompleteViewModel()
    
    @State private var searchCancellable: DispatchWorkItem?
    
    // Dummy state for triggering view refresh
    @State private var refreshView = false
    
    var body: some View {
        ZStack {
            if showSpinner {
                // Show the spinner
                ProgressView("Fetching Data...")
            } else {
                // Show the home screen view
                NavigationView {
                    VStack {
                        if searchText.isEmpty {
                            mainContent
                        } else {
                            searchResultsView
                        }
                    }
                    .navigationTitle("Stocks")
                    .toolbar {
                        if !isSearching {
                            EditButton()
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search")
                    .focused($isSearchFocused)
                    .onChange(of: searchText) { _,newValue in
                        isSearching = !newValue.isEmpty
                        performSearch(query: newValue)
                    }
                    .onSubmit(of: .search) {
                        isSearchFocused = false
                    }
                    .onAppear {
                        // Start a timer to refresh data periodically
                        Timer.scheduledTimer(withTimeInterval: 100, repeats: true) { _ in
                            watchlistViewModel.refreshFavorites()
                            portfolioViewModel.refreshPortfolio()
                        }
                        watchlistViewModel.refreshFavorites()
                        portfolioViewModel.refreshPortfolio()
                    }
                    // Add an onChange here to listen to changes in watchlist
                    .onChange(of: watchlistViewModel.favoritesCount) { _,_ in
                        self.refreshView.toggle()  // Toggling the dummy state to force refresh
                    }
                }
                .environmentObject(portfolioViewModel)
                .environmentObject(watchlistViewModel)
            }
        }
        .onAppear {
            // Start a timer to hide the spinner after 1 second
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.showSpinner = false
                }
            }
        }
    }

    var mainContent: some View {
        List {
            Text(currentDateFormatted)
                .font(.title.bold())
                .foregroundStyle(.secondary)
                .padding(5)
            
            PortfolioView(netWorth: netWorth(),
                          cashBalance: portfolioViewModel.balance, portfolioViewModel: portfolioViewModel)
            
            FavoritesView(viewModel: watchlistViewModel)
            
            HStack {
                Spacer()
                Link("Powered by Finhub.io", destination: URL(string: "https://finhub.io/")!)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
    }

    var searchResultsView: some View {
        List(autoCompleteViewModel.searchResults, id: \.symbol) { result in
            NavigationLink(destination: StockDetailsView(symbol: result.symbol)
                .environmentObject(portfolioViewModel)
                .environmentObject(watchlistViewModel)
            ) {
                VStack(alignment: .leading) {
                    Text(result.description)
                        .fontWeight(.bold)
                    Text(result.displaySymbol)
                        .foregroundColor(.gray)
                }
            }
            .simultaneousGesture(TapGesture().onEnded {
                isSearchFocused = false
                searchText = ""
            })
        }
        .navigationBarTitle("Stocks")
    }

    private func performSearch(query: String) {
        if query.isEmpty {
            autoCompleteViewModel.clearResults()
            return
        }
        searchCancellable?.cancel()
        let task = DispatchWorkItem {
            self.autoCompleteViewModel.fetchAutoCompleteResults(query: query)
        }
        searchCancellable = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
    }
    
    private var currentDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: currentDate)
    }
    
    private func netWorth() -> Double {
        let totalStockValue = portfolioViewModel.stocks.reduce(0) { $0 + $1.marketValue }
        return totalStockValue + portfolioViewModel.balance
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
