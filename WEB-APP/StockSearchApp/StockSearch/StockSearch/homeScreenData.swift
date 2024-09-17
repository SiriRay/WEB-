//
//  homeScreenData.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/13/24.
//

import Foundation

struct FavoriteStock: Decodable, Identifiable {
    var id: String
    var symbol: String
    var companyName: String
    var currentPrice: Double?
    var change: Double?
    var changePercentage: Double?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case symbol
        case companyName = "name"
        case currentPrice
        case change
        case changePercentage
    }
}


//// Decodable response structure for the portfolio details
//struct PortfolioResponse: Decodable {
//    var stocks: [PortfolioStock]
//    var wallet: Double
//}
//
//// Model for individual stocks in the portfolio
//struct PortfolioStock: Decodable, Identifiable {
//    let id: String
//    let symbol: String
//    let quantity: Int
//    let totalCost: Double
//}
//

struct PortfolioResponse: Decodable {
    var stocks: [PortfolioStock]
    var wallet: Double
}


//struct PortfolioStock: Decodable, Identifiable {
//    var id: String
//    var symbol: String
//    var marketValue: Double?
//    var quantity: Int
//    var totalCost: Double
//    var change: Double // The absolute change in price
//    var changePercentage: Double? // The percentage change
//    var avgCost: Double
//    
//    
//
//    enum CodingKeys: String, CodingKey {
//            case id = "_id"
//            case symbol, marketValue, quantity, totalCost, change, changePercentage, avgCost
//        }
//    
//    // Computed properties to update marketValue, change, and changePercentage based on the currentPrice
//    mutating func updateMarketValues(currentPrice: Double) {
//        self.marketValue = currentPrice * Double(quantity)
//        self.avgCost = totalCost / Double(quantity)
//        self.change = currentPrice - avgCost
//        self.changePercentage = (self.change / avgCost) * 100
//    }
//    
//}

struct PortfolioStock: Decodable, Identifiable {
    var id: String
    var symbol: String
    var quantity: Int
    var totalCost: Double
    var avgCost: Double { return totalCost / Double(quantity) }  // Computed property for average cost per share

    // Properties that are not part of the JSON response but need to be initialized
    var currentPrice: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case symbol, quantity, totalCost
    }

    var marketValue: Double {
        return currentPrice * Double(quantity)
    }

    var change: Double {
        return currentPrice - avgCost
    }

    var changePercentage: Double? {
        return (change / avgCost) * 100
    }

    // Since we need a custom initializer to handle properties not in the JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        symbol = try container.decode(String.self, forKey: .symbol)
        quantity = try container.decode(Int.self, forKey: .quantity)
        totalCost = try container.decode(Double.self, forKey: .totalCost)
        // Initialize currentPrice with default 0.0, update it after fetching from another API
        currentPrice = 0.0
    }
    
    mutating func updateMarketValues(currentPrice: Double) {
            self.currentPrice = currentPrice
        }
}



