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

protocol MovieDatabaseAPI: NetworkAPI {

}

extension MovieDatabaseAPI {
    var baseUrl: String {
        "https://movie-database-imdb-alternative.p.rapidapi.com/"
    }

    var headers: [String: String]? {
        ["x-rapidapi-key": "9802aa9cc0msh5015fe6656c4e89p1fe776jsn0b8dd7404dd9",
                                                  "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com"]
    }
}
