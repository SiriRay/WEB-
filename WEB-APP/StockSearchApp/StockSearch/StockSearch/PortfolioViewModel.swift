//
//  PortfolioViewModel.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/29/24.
//

import Foundation

class PortfolioViewModel: ObservableObject {
    @Published var stocks: [PortfolioStock] = []
    @Published var balance: Double = 0.0
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadPortfolioDetails() {
        isLoading = true
        errorMessage = nil
        let detailsURL = "http://localhost:3000/api/portfolio/details"
        
//        print("loading details")

        fetch(urlString: detailsURL) { [weak self] (result: Result<PortfolioResponse, Error>) in
//            print("trying to fetch")
            DispatchQueue.main.async {
//                print("result")
//                print(result)
                switch result {
                case .success(let response):
//                    print("fetch success")
                    self?.balance = response.wallet
                    self?.updateStockDetails(stocks: response.stocks)
                case .failure(let error):
                    self?.errorMessage = "Failed to load portfolio: \(error.localizedDescription)"
                    self?.isLoading = false
                }
            }
        }
    }
    
    func refreshPortfolio() {
        loadPortfolioDetails()  // This method should already be implemented to fetch the latest portfolio details
    }


    private func updateStockDetails(stocks: [PortfolioStock]) {
        let group = DispatchGroup()
        var updatedStocks = stocks
        
//        print("loading  stock details")

        for index in stocks.indices {
            group.enter()
            let summaryURL = "http://localhost:3000/api/stock/summary?symbol=\(stocks[index].symbol)"

            fetch(urlString: summaryURL) { (result: Result<StockDetails, Error>) in
//                print("updaing stock")
                switch result {
                case .success(let summary):
                    updatedStocks[index].updateMarketValues(currentPrice: summary.currentPrice)
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to fetch stock details for \(stocks[index].symbol): \(error.localizedDescription)"
                    }
                }
                group.leave()
            }
        }
//        print("stocks")
        group.notify(queue: .main) {
            self.stocks = updatedStocks.sorted(by: { $0.symbol < $1.symbol })
            self.isLoading = false
        }
    }
    
    
    
    func buyStock(symbol: String, quantity: Int, pricePerShare: Double) {
            let buyURL = URL(string: "http://localhost:3000/api/portfolio/buy")!
            var request = URLRequest(url: buyURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = ["symbol": symbol, "quantity": quantity, "pricePerShare": pricePerShare]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to buy stock: \(error?.localizedDescription ?? "Unknown error")"
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.refreshPortfolio()
                }
            }.resume()
        }

        func sellStock(symbol: String, quantity: Int, pricePerShare: Double) {
            let sellURL = URL(string: "http://localhost:3000/api/portfolio/sell")!
            var request = URLRequest(url: sellURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = ["symbol": symbol, "quantity": quantity, "pricePerShare": pricePerShare]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to sell stock: \(error?.localizedDescription ?? "Unknown error")"
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.refreshPortfolio()
                }
            }.resume()
        }
    
    
    
    
    
    
    
    

    private func fetch<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
//        print("efe")
        URLSession.shared.dataTask(with: url) { data, response, error in
//            print("cmpl")
            if let error = error {
                completion(.failure(error))
//                print("cmpl")
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -2, userInfo: nil)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
//                print("cmpl")
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}




