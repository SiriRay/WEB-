//
//  AutoCompleteView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 5/1/24.
//

import SwiftUI

//import SwiftUI
//
//struct AutoCompleteView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    AutoCompleteView()
//}

//
//import SwiftUI
//
//struct AutoCompleteView: View {
//    @StateObject private var viewModel = AutoCompleteViewModel()
//    @State private var query: String = ""
//
//    var body: some View {
//        NavigationView {
////            Text("hello")
//            List(viewModel.searchResults, id: \.symbol) { result in
//                VStack(alignment: .leading) {
//                    Text(result.description)
//                    Text(result.displaySymbol)
//                        .foregroundColor(.gray)
//                }
//            }
//            .navigationBarTitle("Search")
//            .navigationBarItems(trailing: Button("Search") {
//                viewModel.fetchAutoCompleteResults(query: query)
//            })
//            .searchable(text: $query)
//        }
//    }
//}


//import SwiftUI
//import Combine
//
//struct AutoCompleteView: View {
//    @StateObject private var viewModel = AutoCompleteViewModel()
//    @State private var query: String = "AAPL"
//
//    // Use a Combine publisher to handle debouncing
//    @State private var searchCancellable: AnyCancellable?
//
//    var body: some View {
//        NavigationView {
////            Text("hello")
//            List(viewModel.searchResults, id: \.symbol) { result in
//                VStack(alignment: .leading) {
//                    Text(result.description)
//                    Text(result.displaySymbol)
//                        .foregroundColor(.gray)
////                    print("\(query) hello")
//                }
//            }
//            .navigationBarTitle("Search")
//            .searchable(text: $query)
//            .onChange(of: query) { _,newValue in
//                // Cancel the existing timer and start a new one each time the query changes
//                print("helllo")
//                searchCancellable?.cancel()
//                searchCancellable = Just(newValue)
//                    .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
//                    .sink { [weak viewModel] searchTerm in
//                        // Ensure the searchTerm is not empty and not just whitespace
//                        if searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
//                            print("calling autocomp")
//                            viewModel?.fetchAutoCompleteResults(query: searchTerm)
//                        }
//                    }
//            }
//        }
//    }
//}


//import SwiftUI
//
//struct AutoCompleteTestView: View {
//    @StateObject private var viewModel = AutoCompleteViewModel()
//    @State private var query: String = "AAPL"
//
//    var body: some View {
//        VStack {
//            TextField("Search query", text: $query, onCommit: {
//                viewModel.fetchAutoCompleteResults(query: query)
//            })
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding()
//
//            if viewModel.isLoading {
//                ProgressView("Loading...")
//            } else if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//            } else {
//                List(viewModel.searchResults, id: \.symbol) { result in
//                    VStack(alignment: .leading) {
//                        Text(result.description)
//                            .fontWeight(.bold)
//                        Text(result.displaySymbol)
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//        }
//        .padding()
//        .onAppear {
//            viewModel.fetchAutoCompleteResults(query: query) // Initial fetch for demo
//        }
//    }
//}


//#Preview {
//    AutoCompleteTestView()
//}

//
//struct AutoCompleteTestView: View {
//    @StateObject private var viewModel = AutoCompleteViewModel()
//    @State private var query: String = "AAPL"
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Search query", text: $query, onCommit: {
//                    viewModel.fetchAutoCompleteResults(query: query)
//                })
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//                if viewModel.isLoading {
//                    ProgressView("Loading...")
//                } else if let errorMessage = viewModel.errorMessage {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                } else {
//                    List(viewModel.searchResults, id: \.symbol) { result in
//                        NavigationLink(destination: StockDetailsView(symbol: result.symbol)) {
//                            VStack(alignment: .leading) {
//                                Text(result.description)
//                                    .fontWeight(.bold)
//                                Text(result.displaySymbol)
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                }
//            }
//            .padding()
//            .navigationBarTitle("Search Stocks")
//            .onAppear {
//                viewModel.fetchAutoCompleteResults(query: query) // Initial fetch for demo
//            }
//        }
//    }
//}
//
//
//
//// Preview with EnvironmentObject
//struct AutoCompleteTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        AutoCompleteTestView()
//            .environmentObject(PortfolioViewModel()) // Providing PortfolioViewModel here
//    }
//}


//
//
//import SwiftUI
//
//struct AutoCompleteTestView: View {
//    @StateObject private var viewModel = AutoCompleteViewModel()
//    @State private var query: String = ""
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.searchResults, id: \.symbol) { result in
//                NavigationLink(destination: StockDetailsView(symbol: result.symbol).environmentObject(PortfolioViewModel())) {
//                    VStack(alignment: .leading) {
//                        Text(result.description)
//                            .fontWeight(.bold)
//                        Text(result.displaySymbol)
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//            .navigationBarTitle("Search Stocks")
//            .searchable(text: $query, prompt: "Search for a stock")
//            .onChange(of: query) { _,newValue in
//                // Trigger search when the query is changed
//                viewModel.fetchAutoCompleteResults(query: newValue)
//            }
//        }
//        .onAppear {
//            if query.isEmpty {
////                viewModel.fetchAutoCompleteResults(query: "AAPL") 
//                // Initial fetch for demo purposes, can be removed if not needed
//            }
//        }
//    }
//}
//
//// Preview with EnvironmentObject
//struct AutoCompleteTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        AutoCompleteTestView()
//            .environmentObject(PortfolioViewModel()) // Providing PortfolioViewModel here
//    }
//}


//below is working autocomplete view with debounce
import SwiftUI

struct AutoCompleteView: View {
    @StateObject private var viewModel = AutoCompleteViewModel()
    @State private var query: String = ""
    @State private var debounceTimer: Timer?

    var body: some View {
        NavigationView {
            List(viewModel.searchResults, id: \.symbol) { result in
                NavigationLink(destination: StockDetailsView(symbol: result.symbol).environmentObject(PortfolioViewModel())) {
                    VStack(alignment: .leading) {
                        Text(result.description)
                            .fontWeight(.bold)
                        Text(result.displaySymbol)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationBarTitle("Stocks")
            .searchable(text: $query)
            .onChange(of: query) { _,newValue in
                // Invalidate and nullify the existing timer
                debounceTimer?.invalidate()
                debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    viewModel.fetchAutoCompleteResults(query: newValue)
                }
            }
        }
    }
}

// Preview with EnvironmentObject
struct AutoCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        AutoCompleteView()
            .environmentObject(PortfolioViewModel()) // Providing PortfolioViewModel here
    }
}
