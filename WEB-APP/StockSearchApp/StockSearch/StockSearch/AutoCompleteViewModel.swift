//
//  AutoCompleteViewModel.swift
//  StockSearch
//
//  Created by Karthik Kancharla on 5/1/24.
//

//import Foundation
//
//import Combine
//
//class AutoCompleteViewModel: ObservableObject {
//    @Published var searchResults: [SearchResult] = []
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//
//    private var cancellables: Set<AnyCancellable> = []
//
//    func fetchAutoCompleteResults(query: String) {
////        print("fetching autocomplete")
//        let urlString = "http://localhost:3000/api/search?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
//        guard let url = URL(string: urlString) else {
//            self.errorMessage = "Invalid URL"
//            return
//        }
//
//        isLoading = true
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: SearchResults.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//                self?.isLoading = false
//                if case .failure(let error) = completion {
//                    self?.errorMessage = "Failed to load data: \(error.localizedDescription)"
//                }
//            }, receiveValue: { [weak self] fetchedData in
//                self?.searchResults = fetchedData.result
////                print(self?.searchResults ?? [])
//            })
//            .store(in: &cancellables)
//    }
//}


import Foundation
import Combine

class AutoCompleteViewModel: ObservableObject {
    @Published var searchResults: [SearchResult] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables: Set<AnyCancellable> = []

    func fetchAutoCompleteResults(query: String) {
        let urlString = "http://localhost:3000/api/search?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .map { results in
                results.result.filter { result in
                    result.type == "Common Stock" && !result.symbol.contains(".")
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = "Failed to load data: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] filteredResults in
                self?.searchResults = filteredResults
            })
            .store(in: &cancellables)
    }
    
    
    func clearResults() {
        searchResults = []
        errorMessage = nil
    }

}
