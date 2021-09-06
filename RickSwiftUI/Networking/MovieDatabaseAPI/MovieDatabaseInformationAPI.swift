//
//  MovieDatabaseInformationAPI.swift
//  MovieDatabaseInformationAPI
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import Foundation

class MovieDatabaseInformationAPI: MovieDatabaseAPI {
    typealias APIData = MovieDatabaseInformationResult

    func getInformationForMovie(withImdbID imdbID: String,
                                completion: @escaping (NetworkResult<MovieDatabaseInformationResult>) -> Void) {
        let parameters = [URLQueryItem(name: "i", value: imdbID),
                          URLQueryItem(name: "r", value: "json")]
        self.get(withParameters: parameters,
                 completion: completion)
    }
}
