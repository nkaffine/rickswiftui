//
//  MovieWatchList.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import SwiftUI

struct MovieWatchList: View {
    @ObservedObject
    var viewModel: MovieWatchListViewModel
    var body: some View {
        Text("Hello, World!")
            .onAppear(perform: {
                viewModel.search(forMovieWithTitle: "Avengers: Endgame")
            })
    }
}

struct MovieWatchList_Previews: PreviewProvider {
    static var previews: some View {
        MovieWatchList(viewModel: MovieWatchListViewModel())
    }
}
