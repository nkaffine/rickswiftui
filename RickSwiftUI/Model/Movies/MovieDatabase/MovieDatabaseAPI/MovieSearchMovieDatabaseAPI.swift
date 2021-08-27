//
//  MovieSearchMovieDatabaseAPI.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

struct MovieSearchMovieDatabaseAPI: MovieDatabaseProtocol {
    struct MovieResult: MovieSearchResult {
        let title: String
        let id: String
        let posterUrl: URL?
        let year: String
        init(searchResult: MovieDatabaseSearchResult.Movie) {
            self.title = searchResult.title
            self.id = searchResult.id
            self.posterUrl = URL(string: searchResult.posterUrl)
            self.year = searchResult.year
        }
    }
    var movieDatabaseAPI = MovieDatabaseAPI()
    func search(forMovieWithTitle title: String,
                completion: @escaping (NetworkResult<[MovieSearchResult]>) -> Void) {
        movieDatabaseAPI.search(forMovieWithTitle: title) { result in
            switch result {
                case .success(let movies):
                    let convertedMovies: [MovieResult] = movies.map({MovieResult(searchResult: $0)})
                    completion(.success(convertedMovies))
                case .serverError(let error):
                    completion(.serverError(error))
                case .networkError(let error):
                    completion(.networkError(error))
                case .decodingError(let error):
                    completion(.decodingError(error))
            }
        }
    }

    func information(forMovieWithID imdbID: String,
                     completion: @escaping (NetworkResult<MovieInformationResult>) -> Void) {
        print("hello")
    }
}
