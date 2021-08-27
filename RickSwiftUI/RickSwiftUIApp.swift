//
//  RickSwiftUIApp.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/12/21.
//

import SwiftUI

@main
struct RickSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            #if DEBUG
            let model = MockMovieWatchList(watchedMovies: [], unwatchedMovies: [MockMovies.lionKing, MockMovies.endgame])
            let viewModel = MovieListCoordinatorViewModel(model: model)
            MovieListCoordinator(viewModel: viewModel)
            #else
            let model = MockMovieWatchList(watchedMovies: [], unwatchedMovies: [MockMovies.lionKing, MockMovies.endgame])
            let viewModel = MovieListCoordinatorViewModel(model: model)
            MovieListCoordinator(viewModel: viewModel)
            #endif
        }
    }
}
