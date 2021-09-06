//
//  MockMovieDatabaseAPI.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/24/21.
//

import Foundation

struct MockMovieDatabase: MovieDatabaseProtocol {
    static let endgameInformation: MovieInformationResult =
        MockMovieInformationResult(imdbID: "tt4154796",
                                   title: "Avengers: Endgame",
                                   year: "2019",
                                   rating: .PG13,
                                   runtimeInMinutes: 181,
                                   genre: ["Action", "Adventure", "Drama"],
                                   plot: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.",
                                   posterUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_SX300.jpg"))

    static let endgameSerchResults: [MovieSearchResult] =
        [MockMovieSearchResult(title: "Avengers: Endgame",
                               id: "tt4154796",
                               posterUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_SX300.jpg"),
                               year: "2019"),
        MockMovieSearchResult(title: "Avengers: Endgame and the Latest Captain Marvel Outrage!!",
                              id: "tt10025738",
                              posterUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BZjg2ZTM3OTgtY2ExMS00OGM4LTg3NDEtNjQ0MjJiZDFmMGFkXkEyXkFqcGdeQXVyMDY3OTcyOQ@@._V1_SX300.jpg"),
                              year: "2019"),
        MockMovieSearchResult(title: "Marvel Studios' Avengers: Endgame LIVE Red Carpet World Premiere",
                              id: "tt10240638",
                              posterUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BNThjZDgwZTYtMjdmYy00ZmUyLTk4NTUtMzdjZmExODQ3ZmY4XkEyXkFqcGdeQXVyMjkzMDgyNTg@._V1_SX300.jpg"),
                              year: "2019"),
        MockMovieSearchResult(title: "Avengers Endgame: the Butt Plan",
                              id: "tt10399328",
                              posterUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BNTQ1OWQzODktMTY3Zi00OTQxLWExOTYtZTNjZjY5ZTY4M2UyXkEyXkFqcGdeQXVyMTAzMzk0NjAy._V1_SX300.jpg"),
                              year: "2019")]

    var informationNetworkResult: NetworkResult<MovieInformationResult> = .success(endgameInformation)
    var searchNetworkResult: NetworkResult<[MovieSearchResult]> = .success(endgameSerchResults)


    func search(forMovieWithTitle title: String, completion: @escaping (NetworkResult<[MovieSearchResult]>) -> Void) {
        completion(searchNetworkResult)
    }

    func information(forMovieWithID imdbID: String, completion: @escaping (NetworkResult<MovieInformationResult>) -> Void) {
        completion(informationNetworkResult)
    }
}
