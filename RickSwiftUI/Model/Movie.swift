//
//  Movie.swift
//  Movie
//
//  Created by Nicholas Kaffine on 9/14/21.
//

import Foundation

struct Movie: Equatable {
    let imdbID: String
    let title: String
    let year: String
    let rating: MovieRating
    let runtimeInMinutes: Int
    let genre: [String]
    let plot: String
    let posterUrl: URL?
    var hasBeenWatched: Bool
    let availableStreamingPlatforms: [StreamingPlatform]

    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.imdbID == rhs.imdbID
    }
}
