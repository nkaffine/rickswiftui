//
//  AddMovieSearcher.swift
//  AddMovieSearcher
//
//  Created by Nicholas Kaffine on 8/26/21.
//

import Foundation

class AddMovieSearcher: ObservableObject {
    @Published
    var movies: Loadable<[MovieSearchResult]> = .success([])

    private var movieDatabase: MovieDatabaseProtocol

    init(movieDatabase: MovieDatabaseProtocol) {
        self.movieDatabase = movieDatabase
    }

    func searchForMovies(withTitle title: String) {
        movies = .loading
        movieDatabase.search(forMovieWithTitle: title) { result in
            switch result {
                case .success(let movieInformation):
                    self.movies = .success(movieInformation)
                case .networkError(let error), .serverError(let error), .decodingError(let error):
                    self.movies = .failure(error)
            }
        }
    }
}
