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

struct LocalMovieWatchList: WatchListProtocol {
    typealias Element = Movie

    private var idWatchList = WatchList<String>()
    private var movieFetcher: MovieInformationFetcherProtocol

    init(movieFetcher: MovieInformationFetcherProtocol) {
        self.movieFetcher = movieFetcher
    }

    mutating func add(element: Movie, completion: @escaping (NetworkResult<Bool>) -> Void) {
        idWatchList.add(element: element.imdbID,
                       completion: completion)
    }

    mutating func remove(element: Movie, completion: @escaping (NetworkResult<Bool>) -> Void) {
        idWatchList.remove(element: element.imdbID,
                          completion: completion)
    }

    mutating func markWatched(element: Movie, completion: @escaping (NetworkResult<Bool>) -> Void) {
        idWatchList.markWatched(element: element.imdbID,
                    completion: completion)
    }

    mutating func markUnwatched(element: Movie, completion: @escaping (NetworkResult<Bool>) -> Void) {
        idWatchList.markWatched(element: element.imdbID,
                                completion: completion)
    }

    func fetchUnwatched(completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        idWatchList.fetchUnwatched { [self] result in
            self.convert(watchStatus: false,
                         result: result,
                         completion: completion)
        }
    }

    func fetchWatched(completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        idWatchList.fetchWatched { [self] result in
            self.convert(watchStatus: true,
                         result: result,
                         completion: completion)
        }
    }

    private func convert(watchStatus: Bool,
                         result: NetworkResult<[String]>,
                         completion: @escaping (NetworkResult<[Movie]>) -> Void) {
        switch result {
            case .success(let ids):
                fetchMovieInformation(for: ids) { movieInformationArray in
                    let movies = movieInformationArray.map { movieInfomation in
                        movieInfomation.convertToMovie(watched: watchStatus,
                                                       streamingPlatforms: [])
                    }
                    completion(.success(movies))
                }
            case .serverError(let error):
                completion(.serverError(error))
            case .networkError(let error):
                completion(.networkError(error))
            case .decodingError(let error):
                completion(.decodingError(error))
        }
    }

    private func fetchMovieInformation(for movies: [String],
                                       completion: @escaping ([MovieInformationResult]) -> Void) {
        let fetcher = BatchMovieFetcher(imdbIDs: movies,
                                        movieFetcher: movieFetcher,
                                        completion: completion)
        fetcher.startFetching()
    }
}
