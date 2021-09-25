//
//  MovieCardList.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct MovieCardList<DisplayableMovie: DisplayableMovieProtocol>: View {
    let movies: [DisplayableMovie]
    let watchMovieAction: (Movie) -> Void
    let removeMovieAction: (Movie) -> Void

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: Constants.movieListVerticalSpacing) {
                ForEach(movies) { movieDetail in
                    EditableMovieCard(details: movieDetail) {
                        if let rating = MovieRating(rating: movieDetail.rating),
                           let runtime = RuntimeParser.parseRuntimeInMinutes(from: movieDetail.runtime) {
                            let movie = Movie(imdbID: movieDetail.id,
                                              title: movieDetail.title,
                                              year: movieDetail.year,
                                              rating: rating,
                                              runtimeInMinutes: runtime,
                                              genre: [],
                                              plot: movieDetail.plot,
                                              posterUrl: movieDetail.posterURL,
                                              hasBeenWatched: false,
                                              availableStreamingPlatforms: [])
                            watchMovieAction(movie)
                        }
                    } movieDeleteAction: {
                        if let rating = MovieRating(rating: movieDetail.rating),
                           let runtime = RuntimeParser.parseRuntimeInMinutes(from: movieDetail.runtime) {
                            removeMovieAction(Movie(imdbID: movieDetail.id,
                                                    title: movieDetail.title,
                                                    year: movieDetail.year,
                                                    rating: rating,
                                                    runtimeInMinutes: runtime,
                                                    genre: [],
                                                    plot: movieDetail.plot,
                                                    posterUrl: movieDetail.posterURL,
                                                    hasBeenWatched: false,
                                                    availableStreamingPlatforms: []))
                        }
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
                      watchMovieAction: viewModel.markWatched,
                      removeMovieAction: viewModel.remove)
            .preferredColorScheme(.dark)
    }
}
