//
//  MockMovies.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import Foundation

struct MockMovies {
    static let endgame: Movie =
        MockMovieDatabase.endgameInformation.convertToMovie(watched: false,
                                                               streamingPlatforms: [])
    static let lionKing: Movie =
        MockMovieInformationResult.lionKing.convertToMovie(watched: false,
                                                           streamingPlatforms: [])
}
