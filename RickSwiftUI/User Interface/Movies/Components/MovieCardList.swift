//
//  MovieCardList.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct MovieCardList<Movie: DisplayableMovie>: View {
    let movies: [Movie]

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: Constants.movieListVerticalSpacing) {
                ForEach(movies) { movieDetail in
                    MovieCard(title: movieDetail.title,
                              runtime: movieDetail.runtime,
                              rating: movieDetail.rating,
                              year: movieDetail.year,
                              posterURL: movieDetail.posterURL, movieWatchedAction: {
                        print("\(movieDetail.title) watched")
                    }, movieDeleteAction: {
                        print("\(movieDetail.title) deleted")
                    })
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
        let viewModel = MovieListViewModel(movies: movies)
        MovieCardList(movies: viewModel.movies)
            .preferredColorScheme(.dark)
    }
}
