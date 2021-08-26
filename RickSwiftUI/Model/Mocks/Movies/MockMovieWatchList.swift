//
//  MockMovieWatchList.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import Foundation

struct MockMovieWatchList: MovieWatchListProtocol {
    private let watchedMovies: [Movie]
    private let unwatchedMovies: [Movie]

    init(watchedMovies: [Movie], unwatchedMovies: [Movie]) {
        self.watchedMovies = watchedMovies
        self.unwatchedMovies = unwatchedMovies
    }

    mutating func addMovie(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        print("add movie called")
    }

    mutating func removeMovie(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        print("remove movie called")
    }

    mutating func markWatched(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        print("mark watched called")
    }

    mutating func markUnwatched(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        print("mark unwatched called")
    }

    func fetchUnwatchedMovies(completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                completion(.success(unwatchedMovies))
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
