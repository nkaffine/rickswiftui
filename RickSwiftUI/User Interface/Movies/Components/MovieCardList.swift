//
//  MovieCardList.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct MovieCardList<Movie: DisplayableMovieProtocol>: View {
    let movies: [Movie]
    let watchMovieAction: (String) -> Void
    let removeMovieAction: (String) -> Void

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: Constants.movieListVerticalSpacing) {
                ForEach(movies) { movieDetail in
                    EditableMovieCard(details: movieDetail) {
                        watchMovieAction(movieDetail.id)
                    } movieDeleteAction: {
                        removeMovieAction(movieDetail.id)
                    }
                    .clipped()
                }
            }
        }
    }
}

private struct Constants {
    static let movieListVerticalSpacing: CGFloat = 16
}

struct MovieCardList_Previews: PreviewProvider {
    static var previews: some View {
        let movies = [MockMovies.endgame,
                      MockMovies.lionKing]
        let viewModel = MovieListViewModel(movies: movies) { imdbID in
            print("Watched \(imdbID)")
        } removeMovieAction: { imdbID in
            print("Removed \(imdbID)")
        } addMovieAction: {
            print("Add movie")
        }

        MovieCardList(movies: viewModel.movies,
                      watchMovieAction: viewModel.markMovieWatched,
                      removeMovieAction: viewModel.removeMovie)
            .preferredColorScheme(.dark)
    }
}
