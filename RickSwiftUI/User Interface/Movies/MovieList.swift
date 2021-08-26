//
//  UnwatchedMoveList.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct MovieList: View {
    @ObservedObject
    var viewModel: MovieListViewModel

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            movieListContent
            AddMovieButton()
        }
    }

    private var movieListContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            genreList
            movieList
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var genreList: some View {
        var selectedGenres: [String] = []
        if let selectedGenre = viewModel.selectedGenre {
            selectedGenres.append(selectedGenre)
        }
        return GenreList(genres: viewModel.genres.sorted(),
                         selectedGenres: selectedGenres,
                         itemTapAction: viewModel.selectGenre)
    }

    @ViewBuilder
    private var movieList: some View {
        MovieCardList(movies: viewModel.movies)
    }
}

struct UnwatchedMoveList_Previews: PreviewProvider {
    static var previews: some View {
        let movies = [MockMovies.endgame,
                      MockMovies.lionKing]
        let viewModel = MovieListViewModel(movies: movies)
        MovieList(viewModel: viewModel)
        .preferredColorScheme(.dark)
    }
}
