//
//  MovieSearchViewModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/21/21.
//

import Foundation

class MovieSearchViewModel: ObservableObject {
    private var searcher: MovieDatabaseAPI = MovieDatabaseAPI()

//    @Published
//    private (set) var currentSearch: [MovieDatabaseResult.Movie]?

    func search(forMovieWithTitle title: String) {
//        searcher.search(forMovieWithTitle: title) { movieResult in
//            switch movieResult {
//                case .success(let movies):
//                    DispatchQueue.main.async {
//                        self.currentSearch = movies
//                    }
//                case .networkError(let error):
//                    print(error)
//                case .serverError(let error):
//                    print(error)
//            }
//        }
    }
}
