//
//  MovieModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

enum LocalMovieWatchListErrors: Error {
    case movieAlreadyAdded
    case movieNotFound
}

struct LocalMovieWatchList: MovieWatchListProtocol {
    private struct WatchListEntry {
        let imdbID: String
        var watched: Bool

        mutating func updateWatchStatus(to watched: Bool) {
            self.watched = watched
        }
    }

    private var movies: [WatchListEntry] = []

    mutating func addMovie(imdbID: String,
                           completion: @escaping (NetworkResult<Bool>) -> Void) {
        if movies.first(where: { entry in
                entry.imdbID == imdbID
        }) == nil {
            movies.append(WatchListEntry(imdbID: imdbID, watched: false))
            completion(.success(true))
        } else {
            completion(.serverError(LocalMovieWatchListErrors.movieAlreadyAdded))
        }
    }

    mutating func removeMovie(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        if let indexToRemove = movies.firstIndex(where: { entry in
            entry.imdbID == imdbID
        }) {
            movies.remove(at: indexToRemove)
        }
        completion(.success(true))
    }

    mutating private func updateWatchStatus(to watched: Bool,
                                            forMovieWithImdbID imdbID: String,
                                            completion: @escaping (NetworkResult<Bool>) -> Void) {
        if let indexToUpdate = movies.firstIndex(where: { entry in
            entry.imdbID == imdbID
        }) {
            movies[indexToUpdate].watched = watched
            completion(.success(true))
        } else {
            completion(.serverError(LocalMovieWatchListErrors.movieNotFound))
        }
    }

    mutating func markWatched(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        updateWatchStatus(to: true, forMovieWithImdbID: imdbID, completion: completion)
    }

    mutating func markUnwatched(imdbID: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        updateWatchStatus(to: false, forMovieWithImdbID: imdbID, completion: completion)
    }


    private func fetchMovies(watched: Bool,
                             completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        let movieIds = movies.compactMap { entry in
            return entry.watched == watched ? entry.imdbID : nil
        }
        let fetcher = MovieInformationFetcher(imdbIDs: movieIds,
                                              movieDatabase: MockMovieDatabaseAPI()) { movieInformationArray in
            let unwatchedMovies: [Movie] = movieInformationArray.compactMap { movieInformation in
                guard let movieEntry = self.movies.first(where: { entry in
                    entry.imdbID == movieInformation.imdbID
                }) else {
                    return nil
                }
                return Movie(imdbID: movieInformation.imdbID,
                             title: movieInformation.title,
                             year: movieInformation.year,
                             rating: movieInformation.rating,
                             runtimeInMinutes: movieInformation.runtimeInMinutes,
                             genre: movieInformation.genre,
                             plot: movieInformation.plot,
                             posterUrl: movieInformation.posterUrl,
                             hasBeenWatched: movieEntry.watched,
                             availableStreamingPlatforms: [])
            }
            completion(.success(unwatchedMovies))
        }
        fetcher.startFetching()
    }

    func fetchUnwatchedMovies(completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        fetchMovies(watched: false, completion: completion)
    }

    func fetchWatchedMovies(completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        fetchMovies(watched: true, completion: completion)
    }

    func fetchUnwatchedMovies(with genre: String, completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        fetchMovies(watched: false) { result in
            switch result {
                case .success(let movies):
                    completion(.success(movies.filter({ movie in
                        movie.genre.contains(genre)
                    })))
                default:
                    completion(result)
            }
        }
    }
}
