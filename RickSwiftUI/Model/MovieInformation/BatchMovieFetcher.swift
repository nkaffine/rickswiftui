//
//  MovieFetcher.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/24/21.
//

import Foundation

class BatchMovieFetcher {
    private let completion: ([MovieInformationResult]) -> Void
    private let fetchedDataLock = NSLock()
    private let idsToFetch: [String]
    private var fetchedData: [NetworkResult<MovieInformationResult>]
    private let movieFetcher: MovieInformationFetcherProtocol

    init(imdbIDs: [String],
         movieFetcher: MovieInformationFetcherProtocol,
         completion: @escaping ([MovieInformationResult]) -> Void) {
        self.completion = completion
        idsToFetch = imdbIDs
        fetchedData = []
        self.movieFetcher = movieFetcher
    }

    private var successes: [MovieInformationResult] {
        return fetchedData.compactMap { movieResult in
            switch movieResult {
                case .success(let movie):
                    return movie
                case .decodingError, .networkError, .serverError:
                    return nil
            }
        }
    }

    func startFetching() {
        if idsToFetch.isEmpty {
            self.completion([])
        } else {
            idsToFetch.forEach { imdbID in
                movieFetcher.fetch(movieWithID: imdbID) { [weak self] result in
                    self?.fetchedDataLock.lock()
                    self?.fetchedData.append(result)
                    self?.callCompletionIfFinished()
                    self?.fetchedDataLock.unlock()
                }
            }
        }
    }

    private func callCompletionIfFinished() {
        if fetchedData.count == idsToFetch.count {
            completion(successes)
        }
    }
}
