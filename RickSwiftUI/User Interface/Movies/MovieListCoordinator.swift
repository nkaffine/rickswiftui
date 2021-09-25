//
//  MovieListCoordinator.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct MovieListCoordinator<List: WatchListProtocol>: View where List.Element == Movie {
    @ObservedObject
    var viewModel: MovieListCoordinatorViewModel<List>
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
            AddMovieView { movie in
                viewModel.add(movie: movie)
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

private struct MovieListCoordinatorContent<List: WatchListProtocol>: View where List.Element == Movie {
    @ObservedObject
    var viewModel: MovieListCoordinatorViewModel<List>
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
                                                        removeMovieAction: viewModel.delete,
                                                        addMovieAction: addMovieTapAction))
        }
    }
}

struct MovieListCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        let model = LocalMovieWatchList(movieFetcher: MockMovieInformationFetcher())
        let viewModel = MovieListCoordinatorViewModel(model: model)
        MovieListCoordinator(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
