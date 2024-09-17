//
//  StockDetailsViewModel.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//

import Foundation

class StockDetailsViewModel: ObservableObject {
    @Published var stockDetails: StockDetails?
    @Published var companyDetails: CompanyDetails?
    @Published var newsArticles: [NewsArticle] = []
    @Published var peers: [String] = []
    @Published var insiderSentiments: [InsiderSentiment] = []
    @Published var earnings: [Earnings] = []
    @Published var recommendationTrends: [RecommendationTrend] = []
    
    @Published var stockPriceData: [StockPriceDataPoint] = []
    @Published var volumeData: [VolumeDataPoint] = []
    
    @Published var stockHourlyPriceData: [StockHourlyPriceDataPoint] = []
    @Published var hourlyVolumeData: [HourlyVolumeDataPoint] = []
    
    @Published var hourlyChartData: HourlyChartData?
    
    
//    @Published var stockHourlyPriceData: [Double] = []
//    @Published var hourlyVolumeData: [Double] = []
    
    
    @Published var percentageChange: Double? = nil


    
    @Published var isInWatchlist = false
    
    @Published var portfolioStock: PortfolioStock?
    
    
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let dispatchGroup = DispatchGroup()

    func loadAllData(for symbol: String) {
        isLoading = true 

        loadStockSummary(for: symbol)
        loadCompanyDetails(for: symbol)
        loadNews(for: symbol)
        loadPeers(forSymbol: symbol)
        loadInsiderSentiments(for: symbol)
        loadEarnings(for: symbol)
        loadRecommendationTrends(for: symbol)
//        loadStockPriceData(for: symbol)
//        loadStockHourlyData(for: symbol)
        
        checkWatchlistStatus(for: symbol)

        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            // Here you can check if both stockDetails and companyDetails are not nil
            // to update the UI accordingly or handle the case where some data failed to load
            if self.stockDetails == nil || self.companyDetails == nil || self.newsArticles.isEmpty || self.peers.isEmpty{
                self.errorMessage = "Failed to load all data"
            }
        }
    }
    
    private func checkWatchlistStatus(for symbol: String) {
            guard let url = URL(string: "http://localhost:3000/api/watchlist") else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    DispatchQueue.main.async {
                        self.isInWatchlist = false
                    }
                    return
                }
                do {
                    let watchlistItems = try JSONDecoder().decode([FavoriteStock].self, from: data)
                    DispatchQueue.main.async {
                        self.isInWatchlist = watchlistItems.contains { $0.symbol == symbol }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isInWatchlist = false
                    }
                }
            }.resume()
        }
    
    private func loadStockSummary(for symbol: String) {
        dispatchGroup.enter()
        let stockSummaryURL = "http://localhost:3000/api/stock/summary?symbol=\(symbol)"

        fetch(urlString: stockSummaryURL) { (result: Result<StockDetails, Error>) in
            switch result {
            case .success(let details):
                self.stockDetails = details
//                print("stockdetails")
//                print(details)
            case .failure(let error):
                self.errorMessage = "Stock Summary Error: \(error.localizedDescription)"
            }
            self.dispatchGroup.leave()
        }
    }

    private func loadCompanyDetails(for symbol: String) {
        dispatchGroup.enter()
        let companyDetailsURL = "http://localhost:3000/api/company/details?symbol=\(symbol)"

        fetch(urlString: companyDetailsURL) { (result: Result<CompanyDetails, Error>) in
            switch result {
            case .success(let details):
                self.companyDetails = details
            case .failure(let error):
                self.errorMessage = "Company Details Error: \(error.localizedDescription)"
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func loadNews(for symbol: String) {
            dispatchGroup.enter()
            let newsURL = "http://localhost:3000/api/company/news?symbol=\(symbol)"

            fetch(urlString: newsURL) { (result: Result<[NewsArticle], Error>) in
                switch result {
                case .success(let articles):
                    DispatchQueue.main.async {
                        self.newsArticles = articles
//                        print("news articles")
//                        print(articles)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "News Error: \(error.localizedDescription)"
                    }
                }
                self.dispatchGroup.leave()
            }
        }
    
    func loadPeers(forSymbol symbol: String) {
        dispatchGroup.enter()
        let peersURL = "http://localhost:3000/api/company/peers?symbol=\(symbol)"

        fetch(urlString: peersURL) { (result: Result<[String], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let peers):
                    self.peers = peers
//                    print("Peers: \(peers)")
                case .failure(let error):
                    self.errorMessage = "Peers Error: \(error.localizedDescription)"
                }
                self.dispatchGroup.leave()
            }
        }
    }
    
    func loadInsiderSentiments(for symbol: String) {
        dispatchGroup.enter()
        let urlStr = "http://localhost:3000/api/company/insider-sentiment?symbol=\(symbol)"

        fetch(urlString: urlStr) { (result: Result<InsiderSentimentResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.insiderSentiments = response.data
//                    print(self.insiderSentiments)
                case .failure(let error):
                    self.errorMessage = "Insider Sentiments Error: \(error.localizedDescription)"
                }
                self.dispatchGroup.leave()
            }
        }
    }
    
    func loadEarnings(for symbol: String) {
        dispatchGroup.enter()
        let earningsURL = "http://localhost:3000/api/company/earnings?symbol=\(symbol)"

        fetch(urlString: earningsURL) { (result: Result<[Earnings], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let earningsData):
                    self.earnings = earningsData
                case .failure(let error):
                    self.errorMessage = "Earnings Data Error: \(error.localizedDescription)"
                }
                self.dispatchGroup.leave()
            }
        }
    }
    
    func loadRecommendationTrends(for symbol: String) {
            dispatchGroup.enter()
            let urlStr = "http://localhost:3000/api/company/recommendation-trends?symbol=\(symbol)"
            fetch(urlString: urlStr) { (result: Result<[RecommendationTrend], Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let trends):
                        self.recommendationTrends = trends
                    case .failure(let error):
                        self.errorMessage = "Recommendation Trends Error: \(error.localizedDescription)"
                    }
                    self.dispatchGroup.leave()
                }
            }
        }

    func loadStockPriceData(for symbol: String) {
            isLoading = true
            dispatchGroup.enter()
            let urlStr = "http://localhost:3000/api/company/charts-data?symbol=\(symbol)"
            
            fetch(urlString: urlStr) { (result: Result<StockPriceResponse, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self.stockPriceData = response.stockPriceData.map { StockPriceDataPoint(timestamp: $0[0], price: $0[1]) }
                        self.volumeData = response.volumeData.map { VolumeDataPoint(timestamp: $0[0], volume: $0[1]) }
                    case .failure(let error):
                        self.errorMessage = "Stock Price Data Error: \(error.localizedDescription)"
                    }
                    self.isLoading = false
                    self.dispatchGroup.leave()
                }
            }
        }
    

    
//    func loadStockHourlyData(for symbol: String) {
//        print("Initiating request to fetch hourly data for \(symbol)")
//        let urlString = "http://localhost:3000/api/company/summary-charts-data?symbol=\(symbol)"
//        
//        fetch(urlString: urlString) { [weak self] (result: Result<StockHourlyResponse, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let response):
//                    print("Successfully fetched hourly data for \(symbol)")
//                    self?.stockHourlyPriceData = response.stockPriceData
//                    self?.hourlyVolumeData = response.volumeData
//                    print("Hourly Price Data: \(self?.stockHourlyPriceData ?? [])")
//                    print("Hourly Volume Data: \(self?.hourlyVolumeData ?? [])")
//                case .failure(let error):
//                    print("Error fetching hourly data for \(symbol): \(error.localizedDescription)")
//                    self?.errorMessage = "Failed to fetch hourly data: \(error.localizedDescription)"
//                    print("Error Message: \(self?.errorMessage ?? "Unknown error")")
//                }
//                self?.isLoading = false
//            }
//        }
//    }

    func loadStockHourlyData(for symbol: String) {
        isLoading = true
        let urlString = "http://localhost:3000/api/company/summary-charts-data?symbol=\(symbol)"
        fetch(urlString: urlString) { [weak self] (result: Result<HourlyChartData, Error>) in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                    case .success(let data):
                    self?.hourlyChartData = data
                    case .failure(let error):
                    self?.errorMessage = "Failed to fetch hourly data: \(error.localizedDescription)"
                }
            }
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
