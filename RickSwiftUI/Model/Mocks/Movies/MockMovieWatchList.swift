//
//  MockMovieWatchList.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import Foundation

class MockMovieWatchList: MovieWatchListProtocol {
    private var movies: [Movie]

    private var unwatchedMovies: [Movie] {
        return movies.filter({!$0.hasBeenWatched})
    }

    private var watchedMovies: [Movie] {
        return movies.filter({$0.hasBeenWatched})
    }

    init(watchedMovies: [Movie], unwatchedMovies: [Movie]) {
        self.movies = watchedMovies + unwatchedMovies
    }

    func addMovie(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let movie = MockMovieDatabase.endgameInformation.convertToMovie(watched: false, streamingPlatforms: [])
            self?.movies.append(movie)
            completion(.success(true))
        }
    }

    func removeMovie(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let indexToRemove = self?.movies.firstIndex(where: { movie in
                movie.imdbID == imdbID
            }) {
                self?.movies.remove(at: indexToRemove)
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(false))
                }
            }
        }
    }

    func markWatched(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let indexToMarkWatched = self?.movies.firstIndex(where: { movie in
                movie.imdbID == imdbID
            }) {
                self?.movies[indexToMarkWatched].hasBeenWatched = true
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(false))
                }
            }
        }
    }

    func markUnwatched(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        print("mark unwatched called")
    }

    func fetchUnwatchedMovies(completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                completion(.success(self.unwatchedMovies))
            }
        }
    }

    func fetchWatchedMovies(completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        completion(.success(watchedMovies))
    }

    func fetchUnwatchedMovies(with genre: String, completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        completion(.success(unwatchedMovies.filter({ movie in
            movie.genre.contains(genre)
        })))
    }
}
