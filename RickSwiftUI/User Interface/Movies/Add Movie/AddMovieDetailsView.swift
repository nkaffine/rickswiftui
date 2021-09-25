//
//  AddMovieDetailsView.swift
//  AddMovieDetailsView
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import SwiftUI

struct AddMovieDetailsView: View {
    @ObservedObject
    var viewModel: AddMovieDetailsViewModel
    @Binding
    var isPresented: Bool
    let addMovieAction: (Movie) -> Void

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
                                addMovieAction(movie)
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
    static var previews: some View {
        AddMovieDetailsView(viewModel: AddMovieDetailsViewModel(imdbID: "", movieDatabase: MockMovieDatabase()), isPresented: .constant(false)) { movieID in
            print("Movie ID added: \(movieID)")
        }
            .preferredColorScheme(.dark)
    }
}
