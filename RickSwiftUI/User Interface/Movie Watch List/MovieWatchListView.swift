//
//  MovieWatchListView.swift
//  MovieWatchListView
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import SwiftUI

struct MovieWatchListView<List: WatchListProtocol>: View where List.Element == Movie {
    @ObservedObject
    var viewModel: MovieWatchListViewModel<List>
    let movieDatabase: MovieDatabaseProtocol
    @State private var shouldShowAddMovie: Bool = false

    init(viewModel: MovieWatchListViewModel<List>,
         movieDatabase: MovieDatabaseProtocol) {
        self.viewModel = viewModel
        self.movieDatabase = movieDatabase
        self.shouldShowAddMovie = viewModel.shouldShowSearch
    }

    var body: some View {
        VStack {
            HStack {
                Text("Movies").font(.title.bold())
                Spacer()
            }
            .padding(16)
            ZStack(alignment: .bottomLeading) {
                MovieWatchListBodyView(viewModel: viewModel)
                AddMovieButton().onTapGesture {
                    viewModel.startSearching()
                }
                .padding(16)
            }
        }.onAppear {
            viewModel.loadUnwatched()
        }.sheet(isPresented: $shouldShowAddMovie) {
            viewModel.didFinishAddingMovie()
        } content: {
            AddMovieView(movieAdder: viewModel,
                         movieDatabase: movieDatabase)
        }
        .onReceive(viewModel.$shouldShowSearch) { newValue in
            shouldShowAddMovie = newValue
        }
    }
}

struct MovieWatchListView_Previews: PreviewProvider {
    static var previews: some View {
        let watchList = WatchList<String>(elements: ["tt4154796", "tt0110357", "tt2582802", "tt0338013", "tt0485947"])
        let model = MovieWatchList(movieFetcher: MovieInformationFetcher(),
                                   idWatchList: watchList)
        MovieWatchListView(viewModel: MovieWatchListViewModel(model: model), movieDatabase: MockMovieDatabase())
            .preferredColorScheme(.dark)
    }
}
