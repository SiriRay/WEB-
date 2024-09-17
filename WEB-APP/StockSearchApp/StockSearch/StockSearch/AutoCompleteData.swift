//
//  AutoCompleteData.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 5/1/24.
//

import Foundation

struct SearchResult: Decodable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}

struct SearchResults: Decodable {
    let count: Int
    let result: [SearchResult]
}
