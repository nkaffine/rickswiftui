//
//  MovieDatabaseAPI.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/21/21.
//

import Foundation

enum MovieDatabaseAPIErrors: Error {
    case unknownError(String)
    case noDataOrError
}

class MovieDatabaseAPI: NetworkAPI, MovieDatabaseProtocol {
    typealias APIData = MovieDatabaseSearchResult

    var baseUrl: String = "https://movie-database-imdb-alternative.p.rapidapi.com/"
    var headers: [String: String]? = ["x-rapidapi-key": "9802aa9cc0msh5015fe6656c4e89p1fe776jsn0b8dd7404dd9",
                                              "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com"]

    private func handleSuccessfulSearch(data: MovieDatabaseSearchResult,
                                        completion: @escaping (NetworkResult<[ MovieDatabaseSearchResult.Movie]>) -> Void) {
        if let searchResults = data.Search {
            completion(.success(searchResults))
        } else if let errorString = data.Error {
            completion(.serverError(MovieDatabaseAPIErrors.unknownError(errorString)))
        } else {
            completion(.serverError(MovieDatabaseAPIErrors.noDataOrError))
        }
    }

    func search(forMovieWithTitle title: String,
                completion: @escaping (NetworkResult<[MovieDatabaseSearchResult.Movie]>) -> ()) {
        let parameters = [URLQueryItem(name: "s", value: title),
                          URLQueryItem(name: "r", value: "json")]
        self.get(withParameters: parameters, completion: { apiResult in
            switch apiResult {
                case .success(let data):
                    self.handleSuccessfulSearch(data: data, completion: completion)
                case .networkError(let error):
                    completion(.networkError(error))
                case .serverError(let errorString):
                    completion(.serverError(errorString))
                case .decodingError(let error):
                    completion(.decodingError(error))
            }
        })
    }

    func search(forMovieWithTitle title: String, completion: @escaping (NetworkResult<MovieDatabaseSearchResult>) -> Void) {
        let parameters = [URLQueryItem(name: "s", value: title),
                          URLQueryItem(name: "r", value: "json")]
        self.get(withParameters: parameters, completion: { apiResult in
            switch apiResult {
                case .success(let data):
                    self.handleSuccessfulSearch(data: data, completion: completion)
                case .networkError(let error):
                    completion(.networkError(error))
                case .serverError(let errorString):
                    completion(.serverError(errorString))
                case .decodingError(let error):
                    completion(.decodingError(error))
            }
        })
    }

    func information(forMovieWithID imdbID: String, completion: @escaping (NetworkResult<MovieInformationResult.Information>) -> Void) {
        <#code#>
    }
}
