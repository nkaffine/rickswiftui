//
//  AddMovieDetailsView.swift
//  AddMovieDetailsView
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import SwiftUI

struct AddMovieDetailsView<MovieAdder: MovieAdderProtocol>: View {
    @ObservedObject
    var viewModel: AddMovieDetailsViewModel
    @Binding
    var isPresented: Bool
    let movieAdder: MovieAdder

    var body: some View {
        switch viewModel.movieDetails {
            case .loading:
                ProgressView()
            case .success(let displayableMovie):
                MovieDetailSheet(posterURL: displayableMovie.posterURL) {
                    MovieDetailsView(title: displayableMovie.title,
                                     year: displayableMovie.year,
                                     rating: displayableMovie.rating,
                                     runtime: displayableMovie.runtime,
                                     plot: displayableMovie.plot)
                } buttons: {
                    HStack(spacing: 16) {
                        StylizedButton(title: "Add", style: .primary) {
                            if let rating = MovieRating(rating: displayableMovie.rating),
                                let runtime = RuntimeParser.parseRuntimeInMinutes(from: displayableMovie.runtime) {
                                let movie = Movie(imdbID: displayableMovie.id,
                                                  title: displayableMovie.title,
                                                  year: displayableMovie.year,
                                                  rating:  rating,
                                                  runtimeInMinutes: runtime,
                                                  genre: displayableMovie.genres,
                                                  plot: displayableMovie.plot,
                                                  posterUrl: displayableMovie.posterURL,
                                                  hasBeenWatched: false,
                                                  availableStreamingPlatforms: [])
                                self.movieAdder.addMovie(movie: movie, completion: { result in
                                    // TODO: something else
                                    return
                                })
                                isPresented = false
                            }
                        }
                        StylizedButton(title: "Cancel", style: .secondary) {
                            isPresented = false
                        }
                    }.padding([.horizontal, .bottom], 16)
                }
            case .failure:
                Text("Something went wrong")
        }
    }
}

struct AddMovieDetailsView_Previews: PreviewProvider {
    private struct Adder: MovieAdderProtocol {
        func addMovie(movie: Movie, completion: @escaping (NetworkResult<Bool>) -> Void) {
            return
        }
    }

    static var previews: some View {
        AddMovieDetailsView(viewModel:
                                AddMovieDetailsViewModel(imdbID: "",
                                                         movieDatabase: MockMovieDatabase()),
                            isPresented: .constant(false),
                            movieAdder: Adder())
            .preferredColorScheme(.dark)
    }
}
