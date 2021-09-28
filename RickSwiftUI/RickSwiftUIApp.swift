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
//            let model = LocalMovieWatchList(movieFetcher: MockMovieInformationFetcher())
            let watchList = WatchList<String>(elements: ["tt4154796", "tt0110357", "tt2582802", "tt0338013", "tt0485947"])
            let model = MovieWatchList(movieFetcher: MovieInformationFetcher(),
                                       idWatchList: watchList)
            #else
            let model = LocalMovieWatchList(movieFetcher: MovieInformationFetcher())
            #endif
            let viewModel = MovieWatchListViewModel(model: model)
//            let viewModel = MovieListCoordinatorViewModel(model: model)
//            MovieListCoordinator(viewModel: viewModel)
            MovieWatchListView(viewModel: viewModel)
        }
    }
}
