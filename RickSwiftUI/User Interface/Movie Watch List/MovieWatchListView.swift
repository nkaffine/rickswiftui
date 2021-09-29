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
    @State var isPresentingAddMovie = false

    var body: some View {
        VStack {
            HStack {
                Text("Movies").font(.title.bold())
                Spacer()
            }
            .padding(16)
            ZStack {
                MovieWatchListBodyView(viewModel: viewModel)
                AddMovieButton().onTapGesture {
                    isPresentingAddMovie = true
                }
            }
        }.onAppear {
            viewModel.loadUnwatched()
        }.sheet(isPresented: $isPresentingAddMovie) {
            isPresentingAddMovie = false
        } content: {
            AddMovieView(movieAdder: viewModel,
                         movieDatabase: movieDatabase)
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
