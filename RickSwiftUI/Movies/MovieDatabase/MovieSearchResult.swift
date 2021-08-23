//
//  MovieSearchResult.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

protocol MovieSearchResult {
    /// The title of the movie
    var title: String { get }
    /// The imdb id of the movie
    var id: String { get }
    /// The url for the poster of the movie if one is provided
    var posterUrl: URL? { get }
    /// The year the movie was released.
    var year: String { get }
}
