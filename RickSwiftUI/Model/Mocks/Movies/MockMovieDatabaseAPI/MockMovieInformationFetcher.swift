//
//  MockMovieInformationFetcher.swift
//  MockMovieInformationFetcher
//
//  Created by Nicholas Kaffine on 9/14/21.
//

import Foundation

class MockMovieInformationFetcher: MovieInformationFetcherProtocol {
    private let endgame = MockMovieInformationResult(imdbID: "tt4154796",
                                                     title: "Avengers: Endgame",
                                                     year: "2019",
                                                     rating: .PG13,
                                                     runtimeInMinutes: 181,
                                                     genre: ["Action", "Adventure", "Drama"],
                                                     plot: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.",
                                                     posterUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_SX300.jpg"))

    func fetch(movieWithID id: String, completion: @escaping (NetworkResult<MovieInformationResult>) -> Void) {
        completion(.success(endgame))
    }
}
