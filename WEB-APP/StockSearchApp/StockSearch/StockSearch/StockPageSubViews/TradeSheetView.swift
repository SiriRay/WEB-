


import SwiftUI

struct TradeSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    @ObservedObject var portfolioViewModel: PortfolioViewModel
    
    let symbol: String
    let currentPrice: Double
    let companyName: String
    
    @State private var numberOfShares = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    
    @State private var showSuccessView = false
    @State private var tradeAction = "" // "bought" or "sold"
    @State private var tradedShares = 0
    
    var body: some View {
        
        if showSuccessView {
            TradeSuccessView(symbol: symbol, companyName: companyName, shares: tradedShares, action: tradeAction, isPresented: $isPresented, portfolioViewModel: portfolioViewModel)
            
        } 
        
        else {
            // Your existing trade sheet code
            NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        
                        isPresented = false
                    }){
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    //                    Button("Close") {
                    //                        isPresented = false
                    //                    }
                    .padding()
                }
                
                Text("Trade \(companyName) shares")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding()
                
                Spacer()
                
                HStack {
                    TextField("0", text: $numberOfShares)
                        .keyboardType(.numberPad)
                        .font(.system(size: 100))
                    Spacer()
                    
                    VStack {
                        // Since the TextField content is a String, we convert it to Int to check its value
                        let shareCount = Int(numberOfShares) ?? 0
                        Text(shareCount <= 1 ? "Share" : "Shares")
                            .font(.title)
                            .padding(.bottom, 0)
                    }
                }

                .padding(.trailing)
                .padding(.leading,10)
                .padding(.vertical,0)
                .padding(.bottom,0)
                
                HStack {
                    Spacer()
                    Text("x \(currentPrice.formatted(.number.precision(.fractionLength(2))))/share = \(calculateTotal().formatted(.currency(code: "USD")))")
                }
                
                .padding(.vertical,0)
                .padding(.trailing)
                
                Spacer()
                
                Text("\(portfolioViewModel.balance.formatted(.currency(code: "USD"))) available to buy \(symbol)")
                    .font(.footnote)
                //                    .padding(.bottom)
                    .foregroundColor(.secondary)
                
                
                
                HStack {
                    Button("Buy") {
                        print("Buy button ")
                        executeTrade(type: "buy")
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150.0, height: 50)
                    .background(Color.green)
                    .cornerRadius(25)
                    //                    .buttonStyle(.borderedProminent)
                    //                    .disabled(!isValidInput())
                    
                    Button("Sell") {
                        executeTrade(type: "sell")
                        
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150.0, height: 50)
                    .background(Color.green)
                    .cornerRadius(25)
                    //                    .buttonStyle(.borderedProminent)
                    //                    .disabled(!isValidInput())
                }
                .padding()
            }
            .navigationBarHidden(true)
            .toast(isPresenting: $showToast, message: toastMessage)
            .onAppear {
                    // Call to load portfolio details when this view appears
//                    portfolioViewModel.loadPortfolioDetails()
                }
        }
        }
        
        
    }
    
    private func calculateTotal() -> Double {
        
        guard let numShares = Int(numberOfShares)else {
            return 0.0
        }
        //        return Double(numShares) * stock.currentPrice
        let total = Double(numShares) * currentPrice
        return (total * 100).rounded() / 100
    }
    
    
    private func isValidInput() -> Bool {
        guard let numShares = Int(numberOfShares) else {
            // If not a number, immediately false
            return false
        }
        return numShares > 0 // Only return true if more than zero
    }
    
    


    
    
    private func executeTrade(type: String) {
            guard let numShares = Int(numberOfShares) else {
                showToast = true
                toastMessage = "Please enter a valid amount"
                return
            }

            if numShares <= 0 {
                showToast = true
                toastMessage = type == "buy" ? "Cannot buy non-positive shares" : "Cannot sell non-positive shares"
                return
            }

            if type == "buy" {
                if portfolioViewModel.balance < calculateTotal() {
                    showToast = true
                    toastMessage = "Not enough money to buy"
                    return
                }
//                portfolioViewModel.buyStock(symbol: symbol, quantity: numShares, pricePerShare: calculateTotal())
                portfolioViewModel.buyStock(symbol: symbol, quantity: numShares, pricePerShare: currentPrice)
                showSuccess(numShares, action: "bought")
            } else if type == "sell" {
                
                
                guard let stock = portfolioViewModel.stocks.first(where: { $0.symbol == symbol }) else {
                            showToast = true
                            toastMessage = "Not enough shares to sell"
                            return
                        }

                        if stock.quantity < numShares {
                            showToast = true
                            toastMessage = "Not enough shares to sell"
                            return
                        }
                
            
                
                
                
                portfolioViewModel.sellStock(symbol: symbol, quantity: numShares, pricePerShare: currentPrice)
                showSuccess(numShares, action: "sold")
            }
        }
    

    private func showSuccess(_ shares: Int, action: String) {
        tradedShares = shares
        tradeAction = action
        showSuccessView = true
        
        
        
    }
}


struct ToastModifier: ViewModifier {
    @Binding var isPresenting: Bool
    let message: String
    var backgroundColor: Color = Color(.sRGB, red: 0.1, green: 0.1, blue: 0.1, opacity: 1)  // Set default color to dark gray

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                content  // Presenting the main content of the view

                if isPresenting {
                    ZStack {
                        Capsule()
                            .fill(backgroundColor)  // Use the specified background color

                        Text(message)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(width: geometry.size.width / 1.25, height: geometry.size.height / 10)
                    .opacity(isPresenting ? 1 : 0)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeOut, value: isPresenting)
                    .padding(.bottom)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isPresenting = false  // Automatically dismiss the toast after 3 seconds
                        }
                    }
                }
            }}}}

extension View {
    func toast(isPresenting: Binding<Bool>, message: String, backgroundColor: Color = .gray) -> some View {
        self.modifier(ToastModifier(isPresenting: isPresenting, message: message, backgroundColor: backgroundColor))
    }
}



struct TradeSuccessView: View {
    let symbol: String
    let companyName: String
    let shares: Int
    let action: String // "bought" or "sold"
    
    @Binding var isPresented: Bool
    
    @ObservedObject var portfolioViewModel: PortfolioViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("Congratulations!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
            Text("You have successfully \(action) \(shares) \(shares == 1 ? "share" : "shares") of \(symbol)")
                .font(.callout)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button(action: {
                // Handle the action to dismiss this view or return to another view
                self.isPresented = false
                self.portfolioViewModel.loadPortfolioDetails()
                
            }) {
                Text("Done")
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(25)
            }
            .padding()
            .padding(.bottom,40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
        .edgesIgnoringSafeArea(.all)
    }
}
