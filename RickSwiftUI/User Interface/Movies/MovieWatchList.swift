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

    @ViewBuilder
    var body: some View {
        MovieWatchListContent(isLoading: viewModel.isLoading,
                              movies: viewModel.unwatchedMovieDetails)
    }


}

private struct MovieWatchListContent: View {
    let isLoading: Bool
    let movies: [MovieWatchListViewModel.MovieDetails]

    var body: some View {
        VStack(alignment: .leading) {
            title
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var title: some View {
        HStack {
            Text("Movies").font(.title.bold())
            Spacer()
        }
        .padding(16)
    }

    @ViewBuilder
    private var movieList: some View {
        if isLoading {
            ProgressView()
        } else {
            MovieCardList(movies: movies)
        }
    }
}

struct MovieWatchList_Previews: PreviewProvider {
    static var previews: some View {
        let endgame = MockMovieDatabaseAPI.endgameInformation
        let endgameMovie = Movie(imdbID: endgame.imdbID,
                          title: endgame.title,
                          year: endgame.year,
                          rating: endgame.rating,
                          runtimeInMinutes: endgame.runtimeInMinutes,
                          genre: endgame.genre,
                          plot: endgame.plot,
                          posterUrl: endgame.posterUrl,
                          hasBeenWatched: false,
                          availableStreamingPlatforms: [])
        let model = MockMovieWatchList(watchedMovies: [], unwatchedMovies: [endgameMovie])
        MovieWatchList(viewModel: MovieWatchListViewModel(model: model))
            .preferredColorScheme(.dark)
    }
}
