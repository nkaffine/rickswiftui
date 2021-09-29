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
            let movieFetcher = MovieInformationFetcher()
            let idWatchList = WatchList<String>()
            let movieDatabase = MovieDatabase()
            #else
            let movieFetcher = MovieInformationFetcher()
            let idWatchList = WatchList<String>()
            let movieDatabase = MovieDatabase()
            #endif
            let model = MovieWatchList(movieFetcher: movieFetcher,
                                       idWatchList: idWatchList)
            let viewModel = MovieWatchListViewModel(model: model)
            MovieWatchListView(viewModel: viewModel,
                               movieDatabase: movieDatabase)
        }
    }
}
