//
//  AddMovieDetailsViewModel.swift
//  AddMovieDetailsViewModel
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import Foundation

class AddMovieDetailsViewModel: ObservableObject {
    @Published
    var movieDetails: Loadable<DisplayableMovie>

    private var movieDatabase: MovieDatabaseProtocol

    init(imdbID: String, movieDatabase: MovieDatabaseProtocol) {
        movieDetails = .loading
        self.movieDatabase = movieDatabase
        self.movieDatabase.information(forMovieWithID: imdbID) { [weak self] result in
            switch result {
                case .success(let movieDetails):
                    let movie = Movie(imdbID: imdbID,
                                      title: movieDetails.title,
                                      year: movieDetails.year,
                                      rating: movieDetails.rating,
                                      runtimeInMinutes: movieDetails.runtimeInMinutes,
                                      genre: movieDetails.genre,
                                      plot: movieDetails.plot,
                                      posterUrl: movieDetails.posterUrl,
                                      hasBeenWatched: false,
                                      availableStreamingPlatforms: [])
                    self?.movieDetails = .success(DisplayableMovie(movie: movie))
                case .decodingError(let error),
                        .networkError(let error),
                        .serverError(let error):
                    self?.movieDetails = .failure(error)
            }
        }
    }
}
