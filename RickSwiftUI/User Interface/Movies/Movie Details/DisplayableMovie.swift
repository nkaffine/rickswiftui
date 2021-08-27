//
//  DisplayableMovie.swift
//  DisplayableMovie
//
//  Created by Nicholas Kaffine on 8/26/21.
//

import Foundation
import UIKit

struct DisplayableMovie: DisplayableMovieProtocol {
    let id: String
    let title: String
    let year: String
    let rating: String
    let runtime: String
    let posterURL: URL?
    let genres: [String]
    let plot: String
    let streamingServices: [UIImage]

    private static func image(for streamingService: StreamingPlatform) -> UIImage {
        switch streamingService {
            case .disney:
                return UIImage(named: "disney")!
            case .netflix:
                return UIImage(named: "netflix")!
            case .hbo:
                return UIImage(named: "hbo ")!
            case .hulu:
                return UIImage(named: "hulu")!
        }
    }

    init(movie: Movie) {
        id = movie.imdbID
        title = movie.title
        year = movie.year
        switch movie.rating {
            case .G:
                rating = "G"
            case .PG:
                rating = "PG"
            case .PG13:
                rating = "PG-13"
            case .R:
                rating = "R"
        }
        runtime = "\(movie.runtimeInMinutes / 60)h \(movie.runtimeInMinutes % 60)m"
        posterURL = movie.posterUrl
        genres = movie.genre
        plot = movie.plot
        streamingServices = movie.availableStreamingPlatforms.map({ streamingService in
            DisplayableMovie.image(for: streamingService)
        })
    }
}
