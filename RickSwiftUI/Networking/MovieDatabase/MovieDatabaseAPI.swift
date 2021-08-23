//
//  MovieDatabaseAPI.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/21/21.
//

import Foundation

struct MovieDatabaseResult: Decodable {
    struct Movie: Decodable {
        let title: String
        var id: String
        let posterUrl: String
        let type: String
        let year: String

        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case id = "imdbID"
            case posterUrl = "Poster"
            case type = "Type"
            case year = "Year"
        }
    }

    let Search: [Movie]?
    let totalResults: String?
    let Response: String
    let Error: String?
}

class MovieDatabaseAPI: NetworkAPI {
    typealias APIData = MovieDatabaseResult

    var baseUrl: String = "https://movie-database-imdb-alternative.p.rapidapi.com/"
    var headers: [String: String]? = ["x-rapidapi-key": "9802aa9cc0msh5015fe6656c4e89p1fe776jsn0b8dd7404dd9",
                                      "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com"]

    func search(forMovieWithTitle title: String, completion: @escaping (NetworkResult<[MovieDatabaseResult.Movie]>) -> ()) {
        let parameters = [URLQueryItem(name: "s", value: title),
                          URLQueryItem(name: "r", value: "json")]
        self.get(withParameters: parameters, completion: { apiResult in
            switch apiResult {
                case .success(let data):
                    if let searchResults = data.Search {
                        completion(.success(searchResults))
                    }
                    if let errorString = data.Error {
                        completion(.serverError(errorString))
                    }
                case .networkError(let error):
                    completion(.networkError(error))
                case .serverError(let errorString):
                    completion(.serverError(errorString))
            }
        })
    }
}
