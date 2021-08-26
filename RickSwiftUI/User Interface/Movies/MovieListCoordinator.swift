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

    @ViewBuilder
    var body: some View {
        VStack {
            title
            MovieListCoordinatorContent(viewModel: viewModel)
        }
        .padding(16)
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

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(maxHeight: .infinity)
        } else {
            if viewModel.error == nil {
                MovieList(viewModel: MovieListViewModel(movies: viewModel.movies))
            } else {
                Text(viewModel.error ?? "Something went wrong")
            }
        }
    }
}

struct MovieListCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        let model = LocalMovieWatchList()
        let viewModel = MovieListCoordinatorViewModel(model: model)
        MovieListCoordinator(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
