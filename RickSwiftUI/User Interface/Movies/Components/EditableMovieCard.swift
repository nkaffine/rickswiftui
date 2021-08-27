//
//  MovieCard.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/24/21.
//

import SwiftUI

struct EditableMovieCard<MovieDetails: DisplayableMovieProtocol>: View {
    let details: MovieDetails
    let movieWatchedAction: () -> Void
    let movieDeleteAction: () -> Void
    @State private var isPresentingSheet: Bool = false

    var body: some View {
        MovieCard(posterURL: details.posterURL) {
            MovieCardDetails(title: details.title,
                             year: details.year,
                             rating: details.rating,
                             runtime: details.runtime)
        }
               .onTapGesture {
                   isPresentingSheet = true
               }
               .sheet(isPresented: $isPresentingSheet) {
                   isPresentingSheet = false
               } content: {
                   MovieListDetailSheet(details: details,
                                        watchedAction: {
                       movieWatchedAction()
                   }, deleteAction: {
                       movieDeleteAction()
                   },
                                    isPresented: $isPresentingSheet)
               }

    }
}

struct EditableMovieCard_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MockMovies.endgame
        let movieDetails = DisplayableMovie(movie: movie)
        EditableMovieCard(details: movieDetails,
                  movieWatchedAction: {
            print("Movie watched tapped")
        }, movieDeleteAction: {
            print("Movie deleted tapped")
        })
            .preferredColorScheme(.dark)
    }
}
