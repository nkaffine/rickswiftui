//
//  MockMovieInformationResult.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/24/21.
//

import Foundation

struct MockMovieInformationResult: MovieInformationResult {
    let imdbID: String
    let title: String
    let year: String
    let rating: MovieRating
    let runtimeInMinutes: Int
    let genre: [String]
    let plot: String
    let posterUrl: URL?

    func convertToMovie(watched: Bool, streamingPlatforms: [StreamingPlatform]) -> Movie {
        return Movie(imdbID: imdbID,
                     title: title,
                     year: year,
                     rating: rating,
                     runtimeInMinutes: runtimeInMinutes,
                     genre: genre,
                     plot: plot,
                     posterUrl: posterUrl,
                     hasBeenWatched: watched,
                     availableStreamingPlatforms: streamingPlatforms)
    }
}

extension MockMovieInformationResult {
    static let endgame =
        MockMovieInformationResult(imdbID: "tt4154796",
                                   title: "Avengers: Endgame",
                                   year: "2019",
                                   rating: .PG13,
                                   runtimeInMinutes: 181,
                                   genre: ["Action", "Adventure", "Drama"],
                                   plot: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.",
                                   posterUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_SX300.jpg"))

    static let lionKing =
        MockMovieInformationResult(imdbID: "tt0110357",
                                   title: "The Lion King",
                                   year: "1994",
                                   rating: .G,
                                   runtimeInMinutes: 88,
                                   genre: ["Animation", "Adventure", "Drama"],
                                   plot: "Lion prince Simba and his father are targeted by his bitter uncle, who wants to ascend the throne himself.",
                                   posterUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BYTYxNGMyZTYtMjE3MS00MzNjLWFjNmYtMDk3N2FmM2JiM2M1XkEyXkFqcGdeQXVyNjY5NDU4NzI@._V1_SX300.jpg"))
}
