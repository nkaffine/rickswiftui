//
//  MovieFetcher.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/24/21.
//

import Foundation

class MovieInformationFetcher {
    private struct FetchedMovie {
        let imdbID: String
        let result: NetworkResult<MovieInformationResult>
    }
    private let completion: ([MovieInformationResult]) -> Void
    private let fetchedDataLock = NSLock()
    private let idsToFetch: [String]
    private var fetchedData: [FetchedMovie]
    private let movieDatabase: MovieDatabaseProtocol

    init(imdbIDs: [String],
         movieDatabase: MovieDatabaseProtocol,
         completion: @escaping ([MovieInformationResult]) -> Void) {
        self.completion = completion
        idsToFetch = imdbIDs
        fetchedData = []
        self.movieDatabase = movieDatabase
    }

    func startFetching() {
        if idsToFetch.count == 0 {
            self.completion([])
        } else {
            idsToFetch.forEach { imdbID in
                movieDatabase.information(forMovieWithID: imdbID) { [weak self] result in
                    self?.fetchedDataLock.lock()
                    self?.fetchedData.append(FetchedMovie(imdbID: imdbID, result: result))
                    if let fetchedData = self?.fetchedData,
                       let toFetchCount = self?.idsToFetch.count,
                       fetchedData.count == toFetchCount {
                        let fetchedMovieResults: [MovieInformationResult] = fetchedData.compactMap { movie in
                            switch movie.result {
                                case .success(let movieData):
                                    return movieData
                                case .networkError(_):
                                    return nil
                                case .serverError(_):
                                    return nil
                                case .decodingError(_):
                                    return nil
                            }
                        }
                        self?.completion(fetchedMovieResults)
                    }
                    self?.fetchedDataLock.unlock()
                }
            }
        }
    }
}
