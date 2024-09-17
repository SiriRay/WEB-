//
//  stockData.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 4/7/24.
//

import Foundation


struct StockDetails: Codable, Identifiable {
    var id = UUID()
    let symbol: String
    let timeStamp: Int
    let currentPrice: Double
    let previousClosingPrice: Double
    let openingPrice: Double
    let highPrice: Double
    let lowPrice: Double
    let change: Double
    let changePercent: Double

    // Convert Unix timestamp to Date
    var date: Date {
        return Date(timeIntervalSince1970: Double(timeStamp))
    }
    
    enum CodingKeys: String, CodingKey {
            case symbol, timeStamp, currentPrice, previousClosingPrice, openingPrice, highPrice, lowPrice, change, changePercent
        }
}

struct CompanyDetails: Codable {
    let country: String
    let currency: String
    let estimateCurrency: String
    let exchange: String
    let finnhubIndustry: String
    let ipo: String
    let logo: String
    let marketCapitalization: Double
    let name: String
    let phone: String
    let shareOutstanding: Double
    let ticker: String
    let weburl: String
}

struct NewsArticle: Codable, Identifiable {
    let id: Int
    let category: String
    let datetime: Int
    let headline: String
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String

    var formattedDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(datetime))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

extension NewsArticle {
    var isComplete: Bool {
        return !headline.isEmpty && !summary.isEmpty && !url.isEmpty && !formattedDate.isEmpty && !image.isEmpty
    }
    
//    var timeAgo: String {
//            let publicationDate = Date(timeIntervalSince1970: TimeInterval(self.datetime))
//            let relativeFormatter = RelativeDateTimeFormatter()
//            relativeFormatter.unitsStyle = .full
//            return relativeFormatter.localizedString(for: publicationDate, relativeTo: Date())
//        }
    var timeAgo: String {
            let publicationDate = Date(timeIntervalSince1970: TimeInterval(self.datetime))
            let now = Date()
            let calendar = Calendar.current

            // Here, we're breaking down the difference into days, hours, and minutes
            let components = calendar.dateComponents([.day, .hour, .minute], from: publicationDate, to: now)

            // Extracting each component
            let days = components.day ?? 0
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0
            
            // Formatting the string based on the difference
            switch (days, hours, minutes) {
                case (let d, _, _) where d > 0:
                    // If there are days, include them
                    let dayPart = "\(d) day" + (d > 1 ? "s" : "")
                    let hourPart = hours > 0 ? ", \(hours) hr" : ""
                    let minutePart = minutes > 0 ? ", \(minutes) min" : ""
                    return "\(dayPart)\(hourPart)\(minutePart)"
                case (_, let h, _) where h > 0:
                    // No days, but there are hours
                    let hourPart = "\(h) hr"
                    let minutePart = minutes > 0 ? ", \(minutes) min" : ""
                    return "\(hourPart)\(minutePart)"
                case (_, _, let m):
                    // No days, no hours, but there are minutes
                    return "\(m) min"
                default:
                    // Less than a minute ago
                    return "Just now"
            }
        }
}


struct InsiderSentiment: Decodable {
    var symbol: String
    var year: Int
    var month: Int
    var change: Int
    var mspr: Double
}

struct InsiderSentimentResponse: Decodable {
    var data: [InsiderSentiment]
    var symbol: String
}


struct Earnings: Decodable {
    var actual: Double
    var estimate: Double
    var period: String
    var quarter: Int
    var surprise: Double
    var surprisePercent: Double
    var symbol: String
    var year: Int
}
 
struct RecommendationTrend: Decodable {
    var buy: Int
    var hold: Int
    var sell: Int
    var strongBuy: Int
    var strongSell: Int
    var period: String
    var symbol: String
}

struct StockPriceResponse: Codable {
    let stockPriceData: [[Double]]
    let volumeData: [[Double]]
}

struct StockPriceDataPoint: Decodable {
        let timestamp: Double
        let price: Double
    }

    struct VolumeDataPoint: Decodable {
        let timestamp: Double
        let volume: Double
    }


struct StockHourlyPriceDataPoint: Decodable {
    let timestamp: Int
    let price: Double
}

struct HourlyVolumeDataPoint: Decodable {
    let timestamp: Int
    let volume: Int
}

struct StockHourlyResponse: Decodable {
    let stockPriceData: [StockHourlyPriceDataPoint]
    let volumeData: [HourlyVolumeDataPoint]
}

//struct StockHourlyResponse: Decodable {
//    let stockPriceData: [Double]
//    let volumeData: [Double]
//    
//    enum CodingKeys: String, CodingKey {
//            case stockPriceData = "stockPriceData"
//            case volumeData = "volumeData"
//        }
//}


struct HourlyChartData: Decodable {
    let stockPriceData: [[Double]]
    let volumeData: [[Double]]
}

// You can extend this structure to provide more convenient access to the data
extension HourlyChartData {
    var stockPricePoints: [StockHourlyPriceDataPoint] {
        stockPriceData.map { StockHourlyPriceDataPoint(timestamp: Int($0[0]), price: $0[1]) }
    }

    var volumePoints: [HourlyVolumeDataPoint] {
        volumeData.map { HourlyVolumeDataPoint(timestamp: Int($0[0]), volume: Int($0[1])) }
    }
}
