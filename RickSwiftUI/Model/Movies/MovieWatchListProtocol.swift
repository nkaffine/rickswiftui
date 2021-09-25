//
//  MovieModelProtocol.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

protocol MovieWatchListProtocol {
    // MARK: List Editing

    /// Adds a movie to the watch list using its imdbID.
    /// - Parameters:
    ///     - imdbID the id from imdb for the movie
    ///     - completion called with the result of the network call
    mutating func addMovie(imdbID: String,
                  completion: @escaping (NetworkResult<Bool>) -> Void)
    /// Removes a movie to the watch list using its imdbID.
    /// - Parameters:
    ///     - imdbID the id from imdb for the movie
    ///     - completion called with the result of the network call
    mutating func removeMovie(imdbID: String,
                     completion: @escaping (NetworkResult<Bool>) -> Void)

    /// Marks a movie watched
    /// - Parameters:
    ///     - imdbID the id from imdb for the movie
    ///     - completion called with whether the call ws successful
    mutating func markWatched(imdbID: String,
                              completion: @escaping (NetworkResult<Bool>) -> Void)

    /// Marks a movie as unwatched
    /// - Parameters:
    ///     - imdbID the id from imdb for the movie
    ///     - completion called with whether the call was successful
    mutating func markUnwatched(imdbID: String,
                                completion: @escaping (NetworkResult<Bool>) -> Void)

    // MARK: List Querying

    /// Fetches the list of unwatched movies and calls the completion with the result
    /// - Parameter completion the completion that will be called with the fetched data
    func fetchUnwatchedMovies(completion: @escaping (NetworkResult<[Movie]>) -> Void)

    /// Fetches the list of watched movies and calls the completion with the result
    /// - Parameter completion the completion that will be called with the fetched data
    func fetchWatchedMovies(completion: @escaping (NetworkResult<[Movie]>) -> Void)

    /// Fetches the list of unwatched movies in a specific genre and calls the completion with the result
    /// - Parameters:
    ///     - genre the desired genre of movies to be returned
    ///     - completion the completion that will be called with the fetched data
    func fetchUnwatchedMovies(with genre: String,
                              completion: @escaping (NetworkResult<[Movie]>) -> Void)
}
