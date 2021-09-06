//
//  MovieListCoordinator.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct MovieListCoordinator: View {
    @ObservedObject
    var viewModel: MovieListCoordinatorViewModel
    @State
    var shouldPresentSheet: Bool = false

    @ViewBuilder
    var body: some View {
        VStack {
            title
            MovieListCoordinatorContent(viewModel: viewModel) {
                shouldPresentSheet = true
            }
        }
        .padding(16)
        .sheet(isPresented: $shouldPresentSheet) {
            shouldPresentSheet = false
        } content: {
            AddMovieView { imdbID in
                viewModel.addMovie(withID: imdbID)
                shouldPresentSheet = false
            }
        }

    }

    var title: some View {
        HStack {
            Text("Movies").font(.title.bold())
            Spacer()
        }
    }
}

private struct MovieListCoordinatorContent: View {
    @ObservedObject
    var viewModel: MovieListCoordinatorViewModel
    var addMovieTapAction: () -> Void

    var body: some View {
        switch viewModel.movies {
            case .loading:
                ProgressView()
                    .frame(maxHeight: .infinity)
            case .failure:
                Text("Something went wrong")
            case .success(let movies):
                MovieList(viewModel: MovieListViewModel(movies: movies,
                                                        markMovieWatchedAction: viewModel.markWatched,
                                                        removeMovieAction: viewModel.deleteMovie, addMovieAction: addMovieTapAction))
        }
    }
}

struct MovieListCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        let model = LocalMovieWatchList(movieDatabase: MockMovieDatabase())
        let viewModel = MovieListCoordinatorViewModel(model: model)
        MovieListCoordinator(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
