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
            let model = LocalMovieWatchList(movieDatabase: MockMovieDatabase())
            #else
            let model = LocalMovieWatchList(movieDatabase: MovieDatabase())
            #endif
            let viewModel = MovieListCoordinatorViewModel(model: model)
            MovieListCoordinator(viewModel: viewModel)
        }
    }
}
