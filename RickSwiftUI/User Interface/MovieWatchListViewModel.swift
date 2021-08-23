//
//  MovieWatchListViewModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

class MovieWatchListViewModel: ObservableObject {
    // MARK: Intents
    func search(forMovieWithTitle title: String) {
        let searcher = MovieDatabaseAPI()
        searcher.search(forMovieWithTitle: title) { result in
            switch result {
                case .success(let data):
                    print("got data")
                case .networkError(let error):
                    print("network error: \(error.localizedDescription)")
                case .serverError(let error):
                    print("server error: \(error.localizedDescription)")
                case .decodingError(let error):
                    print("decoding error: \(error.localizedDescription)")
            }
        }
    }
}
