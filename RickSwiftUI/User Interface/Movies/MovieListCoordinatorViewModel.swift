//
//  MovieListCoordinatorViewModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import Foundation

class MovieListCoordinatorViewModel: ObservableObject {
    @Published
    private var loadableMovies: Loadable<[Movie]>
    private var model: MovieWatchListProtocol

    init(model: MovieWatchListProtocol) {
        self.model = model
        self.loadableMovies = .loading
        model.fetchUnwatchedMovies(completion: { [weak self] result in
            switch result {
                case .success(let movies):
                    self?.loadableMovies = .success(movies)
                case .networkError(let error),
                     .serverError(let error),
                     .decodingError(let error):
                    self?.loadableMovies = .failure(error)
            }
        })
    }

    // TODO: remove once switches are in view builder (need to update xcode)
    var movies: [Movie] {
        switch loadableMovies {
            case .loading, .failure:
                return []
            case .success(let movies):
                return movies
        }
    }

    var isLoading: Bool {
        switch loadableMovies {
            case .loading:
                return true
            case .success, .failure:
                return false
        }
    }

    var error: String? {
        switch loadableMovies {
            case .failure(let error):
                return error.localizedDescription
            case .success, .loading:
                return nil
        }
    }

}
