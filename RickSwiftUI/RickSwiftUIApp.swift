//
//  RickSwiftUIApp.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/12/21.
//

import SwiftUI

@main
struct RickSwiftUIApp: App {
    private struct MovieAdder: MovieAdderProtocol {
        func addMovie(movie: Movie, completion: @escaping (NetworkResult<Bool>) -> Void) {
            print("called add movie for \(movie.title)")
        }
    }

    var body: some Scene {
        WindowGroup {
            #if DEBUG
            let model = MovieWatchList(movieFetcher: MockMovieInformationFetcher(),
                                       idWatchList: WatchList<String>())
            #else
            let model = MovieWatchList(movieFetcher:    MovieInformationFetcher(),
                                       idWatchList: WatchList<String>())
            #endif
            let viewModel = MovieWatchListViewModel(model: model)
            MovieWatchListView(viewModel: viewModel, movieDatabase: MockMovieDatabase())
        }
    }
}
