//
//  MovieWatchListViewModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation
import UIKit

class MovieWatchListViewModel: ObservableObject {
    struct MovieDetails: DisplayableMovie {
        let id: String
        let title: String
        let year: String
        let rating: String
        let runtime: String
        let posterURL: URL?
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
            self.id = movie.imdbID
            self.title = movie.title
            self.year = movie.year
            switch movie.rating {
                case .G:
                    self.rating = "G"
                case .PG:
                    self.rating = "PG"
                case .PG13:
                    self.rating = "PG-13"
                case .R:
                    self.rating = "R"
            }
            let hours = movie.runtimeInMinutes / 60
            let minutes = movie.runtimeInMinutes % 60
            self.runtime = "\(hours)h \(minutes)m"
            self.posterURL = movie.posterUrl
            self.plot = movie.plot
            self.streamingServices = movie.availableStreamingPlatforms.map({MovieDetails.image(for: $0)})
        }
    }
    var model: MovieWatchListProtocol

    @Published
    private var unwatchedMovies: Loadable<[MovieDetails]>

    @Published
    private var watchedMovies: Loadable<[MovieDetails]>

    init(model: MovieWatchListProtocol) {
        self.model = model
        self.unwatchedMovies = .loading
        self.watchedMovies = .loading
        model.fetchUnwatchedMovies { [weak self] result in
            switch result {
                case .success(let movies):
                    self?.unwatchedMovies = .success(movies.map({ MovieDetails(movie: $0) }))
                case .networkError(let error), .serverError(let error), .decodingError(let error):
                    self?.unwatchedMovies = .failure(error)
            }
        }
        model.fetchWatchedMovies { [weak self] result in
            switch result {
                case .success(let movies):
                    self?.watchedMovies = .success(movies.map({ MovieDetails(movie: $0) }))
                case .networkError(let error), .serverError(let error), .decodingError(let error):
                    self?.watchedMovies = .failure(error)
            }
        }
    }

    var isLoading: Bool {
        switch unwatchedMovies {
            case .loading:
                return true
            case .failure, .success:
                return false
        }
    }

    var unwatchedMovieDetails: [MovieDetails] {
        switch unwatchedMovies {
            case .loading, .failure:
                return []
            case .success(let movieDetails):
                return movieDetails
        }
    }

    var watchedMovieDetails: [MovieDetails] {
        switch watchedMovies {
            case .loading, .failure:
                return []
            case .success(let movieDetails):
                return movieDetails
        }
    }
}
