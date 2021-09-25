//
//  MovieListCoordinatorViewModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import Foundation

protocol MovieAddable: AnyObject {
    func add(movie: Movie)
}

class MovieListCoordinatorViewModel<List: WatchListProtocol>: ObservableObject, MovieAddable where List.Element == Movie {
    @Published
    var movies: Loadable<[Movie]>

    private var model: List

    init(model: List) {
        self.model = model
        self.movies = .loading
        updateMovies()
    }

    private func updateMovies() {
        model.fetchUnwatched { [weak self] result in
            switch result {
                case .success(let movies):
                    self?.movies = .success(movies)
                case .networkError(let error),
                        .serverError(let error),
                        .decodingError(let error):
                    self?.movies = .failure(error)
            }
        }
    }

    // MARK: Intents

    func markWatched(movie: Movie) {
        movies = .loading
        model.markWatched(element: movie) { [weak self] result in
            switch result {
                case .success:
                    self?.updateMovies()
                case .networkError, .serverError, .decodingError:
                    self?.updateMovies()
                    print("something went wrong")
            }
        }
    }

    func delete(movie: Movie) {
        movies = .loading
        model.remove(element: movie) { [weak self] result in
            switch result {
                case .success:
                    self?.updateMovies()
                case .networkError, .serverError, .decodingError:
                    self?.updateMovies()
                    print("something went wrong")
            }
        }
    }

    func add(movie: Movie) {
        movies = .loading
        model.add(element: movie) { [weak self] result in
            switch result {
                case .success:
                    self?.updateMovies()
                case .serverError, .networkError, .decodingError:
                    self?.updateMovies()
            }
        }
    }
}
