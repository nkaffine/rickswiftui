//
//  MovieSearchMovieDatabaseAPI.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

struct MovieSearchMovieDatabaseAPI: MovieDatabaseProtocol {
    func search(forMovieWithTitle title: String, completion: @escaping (NetworkResult<[MovieSearchResult]>) -> Void) {
        print("hello")
    }

    func information(forMovieWithID imdbID: String, completion: @escaping (NetworkResult<MovieInformationResult>) -> Void) {
        print("hello")
    }
}
