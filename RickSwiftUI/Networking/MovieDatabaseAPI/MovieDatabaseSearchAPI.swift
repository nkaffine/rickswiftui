//
//  MovieDatabaseSearchAPI.swift
//  MovieDatabaseSearchAPI
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import Foundation

class MovieDatabaseSearchAPI: MovieDatabaseAPI {
    typealias APIData = MovieDatabaseSearchResult

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
}
