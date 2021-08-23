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
            MovieWatchList(viewModel: MovieWatchListViewModel())
//            MainTabView()
//            MovieSearchView(viewModel: MovieSearchViewModel())
        }
    }
}
