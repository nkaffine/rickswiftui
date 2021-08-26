//
//  MovieDatabaseResult.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

struct MovieDatabaseSearchResult: Decodable {
    /// The movie object returned by the Movie Database API.
    struct Movie: Decodable {
        /// The title of the move
        let title: String
        /// The imdb id of the movie
        let id: String
        /// The url for the poster of the movie
        let posterUrl: String
        /// The type of the result (movie in most cases)
        let type: String
        /// The year the movie was released.
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
