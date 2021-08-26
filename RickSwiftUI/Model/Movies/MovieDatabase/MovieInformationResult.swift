//
//  MovieInformationResult.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

enum MovieRating {
    case G
    case PG
    case PG13
    case R
}

protocol MovieInformationResult {
    /// The imdb id for the movie
    var imdbID: String { get }
    /// The title of the movie
    var title: String { get }
    /// The year the movie was released
    var year: String { get }
    /// The rating of the movie
    var rating: MovieRating { get }
    /// The runtime of the movie in minutes
    var runtimeInMinutes: Int { get }
    /// The genres of the movie
    var genre: [String] { get }
    /// The plot paragraph of the movie
    var plot: String { get }
    /// The poster url for the movie if one is provided.
    var posterUrl: URL? { get }

    /// Converts the movie information result to a movie using the two needed additional pieces of information
    func convertToMovie(watched: Bool, streamingPlatforms: [StreamingPlatform]) -> Movie
}
