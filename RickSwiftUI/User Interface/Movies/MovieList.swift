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
            AddMovieButton().onTapGesture {
                viewModel.addMovie()
            }
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
        MovieCardList(movies: viewModel.movies,
                      watchMovieAction: viewModel.markMovieWatched,
                      removeMovieAction: viewModel.removeMovie)
    }
}

struct UnwatchedMoveList_Previews: PreviewProvider {
    static var previews: some View {
        let movies = [MockMovies.endgame,
                      MockMovies.lionKing]
        let viewModel = MovieListViewModel(movies: movies) { imdbID in
            print("Mark Watched: \(imdbID)")
        } removeMovieAction: { imdbID in
            print("Removed: \(imdbID)")
        } addMovieAction: {
            print("add movie tapped")
        }

        MovieList(viewModel: viewModel)
        .preferredColorScheme(.dark)
    }
}
