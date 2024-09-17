//
//  PortfolioView.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/8/24.
//

//import SwiftUI

//struct PortfolioView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    PortfolioView()
//}
//
//struct PortfolioView: View {
//    let netWorth: Double
//    let cashBalance: Double
//    let portfolioStocks: [PortfolioStock]
//
//    var body: some View {
//        Section(header: Text("PORTFOLIO")) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Net Worth")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    Text("$\(netWorth, specifier: "%.2f")")
//                }
//                Spacer()
//                VStack(alignment: .leading) {
//                    Text("Cash Balance")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    Text("$\(cashBalance, specifier: "%.2f")")
//                }
//            }
//
//            ForEach(portfolioStocks, id: \.symbol) { stock in
//                NavigationLink(destination: StockDetailsView(symbol: stock.symbol)) {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(stock.symbol).font(.title2).bold()
//                            Text("\(stock.shares) shares")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        Spacer()
//                        VStack {
//                            Text("$\(stock.currentPrice, specifier: "%.2f")")
//                                .fontWeight(.bold)
//                            // Update here to show the change when available
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
// below is correct css
//struct PortfolioView: View {
//    let netWorth: Double
//    let cashBalance: Double
//    let portfolioStocks: [PortfolioStock]
//
//    var body: some View {
//        Section(header: Text("PORTFOLIO")) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Net Worth")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    Text("$\(netWorth, specifier: "%.2f")")
//                }
//                Spacer()
//                VStack(alignment: .leading) {
//                    Text("Cash Balance")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    Text("$\(cashBalance, specifier: "%.2f")")
//                }
//            }
//
//            ForEach(portfolioStocks, id: \.symbol) { stock in
//                NavigationLink(destination: StockDetailsView(symbol: stock.symbol)) {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(stock.symbol).font(.title2).bold()
//                            Text("\(stock.quantity) shares")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        Spacer()
//                        VStack(alignment: .trailing) {
//                            Text("$\(stock.currentPrice, specifier: "%.2f")")
//                                .fontWeight(.bold)
//                            HStack {
//                                Image(systemName: stock.change > 0 ? "arrow.up.forward" : stock.change < 0 ? "arrow.down.forward" : "minus")
//                                    .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                Text("$\(stock.change, specifier: "%.2f")")
//                                    .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                if let changePercentage = stock.changePercentage {
//                                    Text("(\(changePercentage, specifier: "%.2f")%)")
//                                        .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                }
//                            }
//                            .fixedSize(horizontal: true, vertical: false)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//below is correct data

//struct PortfolioView: View {
//    let netWorth: Double
//    let cashBalance: Double?
//    let portfolioStocks: [PortfolioStock]
//    
//    @ObservedObject var portfolioViewModel: PortfolioViewModel
//
//    var body: some View {
//        Section(header: Text("PORTFOLIO")) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Net Worth")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    Text("$\(netWorth, specifier: "%.2f")")
//                }
//                Spacer()
//                VStack(alignment: .leading) {
//                    Text("Cash Balance")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    Text("$\(cashBalance ?? 0.0, specifier: "%.2f")")
//                }
//            }
//            
//            ForEach(portfolioStocks, id: \.id) { stock in
//                NavigationLink(destination: StockDetailsView(symbol: stock.symbol)) {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(stock.symbol).font(.title2).bold()
//                            Text("\(stock.quantity) shares @ $\(stock.avgCost, specifier: "%.2f") each")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        Spacer()
//                        VStack(alignment: .trailing) {
//                            Text("$\(stock.marketValue, specifier: "%.2f")")
//                                .fontWeight(.bold)
//                            HStack {
//                                Image(systemName: stock.change > 0 ? "arrow.up.forward" : stock.change < 0 ? "arrow.down.forward" : "minus")
//                                    .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                Text("$\(stock.change, specifier: "%.2f")")
//                                    .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                if let changePercentage = stock.changePercentage {
//                                    Text("(\(changePercentage, specifier: "%.2f")%)")
//                                        .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .onAppear {
//            portfolioViewModel.loadPortfolioDetails() // Calling loadFavorites when the view appears
//        }
//    }
//}


//below is trying to merge both css and correct data
//import SwiftUI
//
//struct PortfolioView: View {
//    let netWorth: Double
//    let cashBalance: Double?
//    @ObservedObject var portfolioViewModel: PortfolioViewModel
//
//    var body: some View {
//        
//        Section(header: Text("PORTFOLIO")) {
//            VStack(alignment: .leading) {
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("Net Worth")
//                            .font(.title2)
//                        Text("$\(netWorth, specifier: "%.2f")")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                    }
//                    Spacer()
//                    VStack(alignment: .leading) {
//                        Text("Cash Balance")
//                            .font(.title2)
//                        Text("$\(cashBalance ?? 0.0, specifier: "%.2f")")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                    }
////                    Divider()
//                }
//                Divider()
//
//
//
//
//
//                ForEach(portfolioViewModel.stocks, id: \.id) { stock in
//                    NavigationLink(destination: StockDetailsView(symbol: stock.symbol)) {
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(stock.symbol).font(.title2).bold()
//                                Text("\(stock.quantity) shares")
//                                    .font(.subheadline)
//                                    .foregroundColor(.secondary)
//                            }
//                            Spacer()
//                            VStack(alignment: .trailing) {
//                                Text("$\(stock.marketValue, specifier: "%.2f")")
//                                    .fontWeight(.bold)
//                                HStack {
//                                    Image(systemName: stock.change > 0 ? "arrow.up.forward" : stock.change < 0 ? "arrow.down.forward" : "minus")
//                                        .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                    Text("$\(stock.change, specifier: "%.2f")")
//                                        .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                    if let changePercentage = stock.changePercentage {
//                                        Text("(\(changePercentage, specifier: "%.2f")%)")
//                                            .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                    }
//                                }
////                                .fixedSize(horizontal: true, vertical: false)
//                                Divider()
//                            }
//                            
////                            .padding(.trailing, 0)
//                        }
//                    }
//                }
//                
//            }
//
//        }
//        
//        .onAppear {
//            portfolioViewModel.loadPortfolioDetails() // Ensure the portfolio details are loaded when the view appears
//        }
//    }
//}
//

// trying to fix dividers
//import SwiftUI
//
//struct PortfolioView: View {
//    let netWorth: Double
//    let cashBalance: Double?
//    @ObservedObject var portfolioViewModel: PortfolioViewModel
//
//    var body: some View {
//        Section(header: Text("PORTFOLIO")) {
//            VStack(alignment: .leading) {
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("Net Worth")
//                            .font(.title2)
//                        Text("$\(netWorth, specifier: "%.2f")")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                    }
//                    Spacer()
//                    VStack(alignment: .leading) {
//                        Text("Cash Balance")
//                            .font(.title2)
//                        Text("$\(cashBalance ?? 0.0, specifier: "%.2f")")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                    }
//                }
//                .padding(.top, 1)
//                Divider()
//
//                // Iterate over stocks with their indices
//                ForEach(Array(portfolioViewModel.stocks.enumerated()), id: \.element.id) { index, stock in
//                    NavigationLink(destination: StockDetailsView(symbol: stock.symbol)) {
//                        VStack {
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text(stock.symbol).font(.title2).bold()
//                                    Text("\(stock.quantity) shares")
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                }
//                                Spacer()
//                                VStack(alignment: .trailing) {
//                                    Text("$\(stock.marketValue, specifier: "%.2f")")
//                                        .fontWeight(.bold)
//                                    HStack {
//                                        Image(systemName: stock.change > 0 ? "arrow.up.forward" : stock.change < 0 ? "arrow.down.forward" : "minus")
//                                            .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                        Text("$\(stock.change, specifier: "%.2f")")
//                                            .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                        if let changePercentage = stock.changePercentage {
//                                            Text("(\(changePercentage, specifier: "%.2f")%)")
//                                                .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
//                                        }
//                                    }
//                                }
////                                Divider()
//                                
//                            }
//                            // Only add a divider if this isn't the last item
//                            if index < portfolioViewModel.stocks.count - 1 {
//                                Divider()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .onAppear {
//            portfolioViewModel.loadPortfolioDetails() // Ensure the portfolio details are loaded when the view appears
//        }
//    }
//}

// some more changes including move
import SwiftUI

struct PortfolioView: View {
    let netWorth: Double
    let cashBalance: Double?
    @ObservedObject var portfolioViewModel: PortfolioViewModel

    var body: some View {
//            List {
                Section(header: Text("PORTFOLIO")) {
//                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Net Worth")
                                    .font(.title2)
                                Text("$\(netWorth, specifier: "%.2f")")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Cash Balance")
                                    .font(.title2)
                                Text("$\(cashBalance ?? 0.0, specifier: "%.2f")")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.top, 1)

                        ForEach(portfolioViewModel.stocks, id: \.id) { stock in
                            NavigationLink(destination: StockDetailsView(symbol: stock.symbol)) {
                                VStack {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(stock.symbol).font(.title2).bold()
                                            Text("\(stock.quantity) shares")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        VStack(alignment: .trailing) {
                                            Text("$\(stock.marketValue, specifier: "%.2f")")
                                                .fontWeight(.bold)
                                            HStack {
                                                Image(systemName: stock.change > 0 ? "arrow.up.forward" : stock.change < 0 ? "arrow.down.forward" : "minus")
                                                    .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
                                                Text("$\(stock.change, specifier: "%.2f")")
                                                    .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
                                                if let changePercentage = stock.changePercentage {
                                                    Text("(\(changePercentage, specifier: "%.2f")%)")
                                                        .foregroundColor(stock.change != 0 ? (stock.change > 0 ? .green : .red) : .secondary)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
//                        .onDelete(perform: portfolioViewModel.deleteStock)
                        .onMove(perform: move)
                    }
//                }
            
//        }
        .onAppear {
            portfolioViewModel.loadPortfolioDetails()
        }
    }

    private func move(from source: IndexSet, to destination: Int) {
        portfolioViewModel.stocks.move(fromOffsets: source, toOffset: destination)
    }
}
