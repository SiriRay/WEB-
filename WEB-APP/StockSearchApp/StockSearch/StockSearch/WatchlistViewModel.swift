////
////  WatchlistViewModel.swift
////  StockSearch
////
////  Created by Karthik Kancharla on 4/13/24.
////
//
//import SwiftUI
//
//struct WatchlistViewModel: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    WatchlistViewModel()
//}



import Foundation

class WatchlistViewModel: ObservableObject {
    @Published var favoriteStocks: [FavoriteStock] = []
    @Published var favoritesCount: Int = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    //Move favorites
    func moveFavorites(from source:IndexSet, to destination: Int){   
        favoriteStocks.move(fromOffsets: source, toOffset: destination)
    }
    
    // Delete favorites
//        func deleteFavorites(at offsets: IndexSet) {
//            favoriteStocks.remove(atOffsets: offsets)
//            // Optional: update the backend or local storage as needed
//        }
    
    // Function to delete a favorite from both the local array and backend
        func deleteFavorites(at offsets: IndexSet) {
            offsets.forEach { index in
                let stockSymbol = favoriteStocks[index].symbol
                deleteFavoriteFromBackend(symbol: stockSymbol) { success in
                    DispatchQueue.main.async {
                        if success {
                            // Proceed to remove from the local array if successful
                            self.favoriteStocks.remove(atOffsets: offsets)
                        } else {
                            // Handle error scenario, maybe show an alert or retry option
                            self.errorMessage = "Failed to delete \(stockSymbol) from the backend."
                        }
                    }
                }
            }
        }

        // Helper function to perform the backend deletion
        private func deleteFavoriteFromBackend(symbol: String, completion: @escaping (Bool) -> Void) {
            guard let url = URL(string: "http://localhost:3000/api/watchlist/delete/\(symbol)") else {
                print("Invalid URL")
                completion(false)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error deleting favorite: \(error)")
                    completion(false)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Unexpected response status code or response type")
                    completion(false)
                    return
                }

                completion(true)
            }

            task.resume()
        }
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    func loadFavorites() {
        isLoading = true
        errorMessage = nil
        let urlString = "http://localhost:3000/api/watchlist"
        
//        print("loading favs called")
        
        fetch(urlString: urlString) { [weak self] (result: Result<[FavoriteStock], Error>) in
//            print("in favs result")
            switch result {
            case .success(let favorites):
//                print("favorites are")
//                print(favorites)
//                print("favs succesful")
                self?.fetchStockDetails(for: favorites)
//                print("the total favs after fetching all data")
//                print(self?.favoriteStocks as Any)
            case .failure(let error):
//                print("loading favs failed")
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to load favorites: \(error.localizedDescription)"
                    self?.isLoading = false
                }
            }
        }
    }
    
    
    func refreshFavorites() {
        loadFavorites()  // This method should already be implemented to fetch the latest favorites data
    }

    
    
    // Add to watchlist
       func addToWatchlist(symbol: String, name: String) {
           let urlString = "http://localhost:3000/api/watchlist/add"
           guard let url = URL(string: urlString) else {
               errorMessage = "Invalid URL"
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           let body: [String: Any] = ["symbol": symbol, "name": name]
           request.httpBody = try? JSONSerialization.data(withJSONObject: body)
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               DispatchQueue.main.async {
                   if let error = error {
                       self.errorMessage = "Failed to add to watchlist: \(error.localizedDescription)"
                       return
                   }
                   guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                       self.errorMessage = "Failed to add to watchlist: Unexpected response"
                       return
                   }
                   self.refreshFavorites()  // Refresh the list after adding
                   self.favoritesCount = self.favoriteStocks.count
               }
           }.resume()
       }

       // Remove from watchlist
       func removeFromWatchlist(symbol: String) {
           let urlString = "http://localhost:3000/api/watchlist/delete/\(symbol)"
           guard let url = URL(string: urlString) else {
               errorMessage = "Invalid URL"
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "DELETE"
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               DispatchQueue.main.async {
                   if let error = error {
                       self.errorMessage = "Failed to remove from watchlist: \(error.localizedDescription)"
                       return
                   }
                   guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                       self.errorMessage = "Failed to remove from watchlist: Item not found"
                       return
                   }
                   self.refreshFavorites()  // Refresh the list after removal
                   self.favoritesCount = self.favoriteStocks.count
               }
           }.resume()
       }
    
    
    

    private func fetchStockDetails(for stocks: [FavoriteStock]) {
        let group = DispatchGroup()
        var detailedStocks: [FavoriteStock] = stocks

        for index in stocks.indices {
            group.enter()
            let summaryURL = "http://localhost:3000/api/stock/summary?symbol=\(stocks[index].symbol)"

            fetch(urlString: summaryURL) { (result: Result<StockDetails, Error>) in
                switch result {
                case .success(let summary):
//                    print("detailed stocks succesful")
                    detailedStocks[index].currentPrice = summary.currentPrice
                    detailedStocks[index].change = summary.change
                    detailedStocks[index].changePercentage = summary.changePercent
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to fetch stock details for \(stocks[index].symbol): \(error.localizedDescription)"
                    }
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.favoriteStocks = detailedStocks
//            print(self.favoriteStocks)
            self.isLoading = false
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    private func fetch<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -2, userInfo: nil)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
