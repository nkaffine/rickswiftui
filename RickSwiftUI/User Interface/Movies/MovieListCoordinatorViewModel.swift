//
//  MovieListCoordinatorViewModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import Foundation



class MovieListCoordinatorViewModel: ObservableObject {
    @Published
    var movies: Loadable<[Movie]>

    private var model: MovieWatchListProtocol

    init(model: MovieWatchListProtocol) {
        self.model = model
        self.movies = .loading
        updateMovies()
    }

    private func updateMovies() {
        model.fetchUnwatchedMovies(completion: { [weak self] result in
            switch result {
                case .success(let movies):
                    self?.movies = .success(movies)
                case .networkError(let error),
                     .serverError(let error),
                     .decodingError(let error):
                    self?.movies = .failure(error)
            }
        })
    }

    // MARK: Intents

    func markWatched(imdbID: String) {
        movies = .loading
        model.markWatched(imdbID: imdbID) { [weak self] result in
            switch result {
                case .success:
                    self?.updateMovies()
                case .networkError, .serverError, .decodingError:
                    self?.updateMovies()
                    print("something went wrong")
            }
        }
    }

    func deleteMovie(imdbID: String) {
        movies = .loading
        model.removeMovie(imdbID: imdbID) { [weak self] result in
            switch result {
                case .success:
                    self?.updateMovies()
                case .networkError, .serverError, .decodingError:
                    self?.updateMovies()
                    print("something went wrong")
            }
        }
    }

    func addMovie(withID id: String) {
        movies = .loading
        model.addMovie(imdbID: id) { [weak self] result in
            switch result {
                case .success:
                    self?.updateMovies()
                case .serverError, .networkError, .decodingError:
                    self?.updateMovies()
            }
        }
    }
}
