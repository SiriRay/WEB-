
import SwiftUI

struct StockPortfolioView: View {
    @EnvironmentObject var portfolioViewModel: PortfolioViewModel
    let symbol: String
    let companyName: String
    let currentPrice: Double
    
    private var stock: PortfolioStock? {
        portfolioViewModel.stocks.first { $0.symbol == symbol }
    }
    
    @State private var showTradeSheet = false
    
    
    var body: some View {
        Text("Portfolio").font(.title2).padding(.bottom,0)
        HStack() {
            VStack(alignment: .leading) {
                if let stock = stock, stock.quantity > 0 {
                    Group {
                        HStack {
                            Text("Shares Owned:")
                                .fontWeight(.bold)

                            Text("\(stock.quantity)")
                        }
                        .padding(.bottom,8)
                        
                        HStack {
                            Text("Avg. Cost / Share:")
                                .fontWeight(.bold)

                            Text("$\(stock.avgCost, specifier: "%.2f")")
                        }
                        .padding(.bottom,8)
                        
                        HStack {
                            Text("Total Cost:")
                                .fontWeight(.bold)

                            Text("$\(stock.totalCost, specifier: "%.2f")")
                        }
                        .padding(.bottom,8)
                        
                        HStack {
                            Text("Change:")
                                .fontWeight(.bold)

                            Text("$\(stock.change, specifier: "%.2f")")
                                .foregroundColor(stock.change == 0 ? .secondary : (stock.change > 0 ? .green : .red))
                        }
                        .padding(.bottom, 8)

                        HStack {
                            Text("Market Value:")
                                .fontWeight(.bold)

                            Text("$\(stock.marketValue, specifier: "%.2f")")
                                .foregroundColor(stock.change == 0 ? .secondary : (stock.change > 0 ? .green : .red))
                        }

                        
                    }
                    .font(.subheadline)
                } else {
                    Text("You have 0 shares of \(symbol). Start trading!")
                        .font(.subheadline)
                        .fontWeight(.regular)
                }
            }
            .padding(0)
            
            Spacer()
            
            Button(action: {
                print("Trade button tapped")
                showTradeSheet = true
            }) {
                Text("Trade")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 120.0, height: 50)
                    .background(Color.green)
                    .cornerRadius(25)
            }
            .sheet(isPresented: $showTradeSheet) {
                            TradeSheetView(isPresented: $showTradeSheet, portfolioViewModel: portfolioViewModel, symbol: symbol, currentPrice: currentPrice, companyName: companyName)
                        }

            .padding(.horizontal)
        }
        .padding(.top,0)
        
    }
}
