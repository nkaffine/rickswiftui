//
//  MovieDatabaseProtocol.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

protocol MovieDatabaseProtocol {
    /// Searches for a movie with the given title and calls the completion with the results
    /// - Parameters:
    ///     - title the title of the movie to search for
    ///     - completion that is called with the search results
    func search(forMovieWithTitle title: String,
                completion: @escaping (NetworkResult<[MovieSearchResult]>) -> Void)
    /// Gets the information for the movie with the given imdb id and calls the completion with the results.
    /// - Parameters:
    ///     - imdbID the id for the movie from imdb
    ///     - completion that will be called with the information results
    func information(forMovieWithID imdbID: String,
                     completion: @escaping (NetworkResult<MovieInformationResult>) -> Void)
}
