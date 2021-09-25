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

    init?(rating: String) {
        switch rating {
            case "G":
                self = .G
            case "PG":
                self = .PG
            case "PG-13":
                self = .PG13
            case "R":
                self = .R
            default:
                return nil
        }
    }
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
}

extension MovieInformationResult {
    /// Converts the movie information result to a movie using the two needed additional pieces of information
    func convertToMovie(watched: Bool, streamingPlatforms: [StreamingPlatform]) -> Movie {
        return Movie(imdbID: imdbID,
                     title: title,
                     year: year,
                     rating: rating,
                     runtimeInMinutes: runtimeInMinutes,
                     genre: genre,
                     plot: plot,
                     posterUrl: posterUrl,
                     hasBeenWatched: watched,
                     availableStreamingPlatforms: streamingPlatforms)
    }
}
