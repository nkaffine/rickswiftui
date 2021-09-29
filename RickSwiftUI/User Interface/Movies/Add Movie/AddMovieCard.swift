//
//  AddMovieCard.swift
//  AddMovieCard
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import SwiftUI

struct AddMovieCard<MovieAdder: MovieAdderProtocol>: View {
    let movie: MovieSearchResult
    @State var shouldPresentSheet: Bool = false
    let movieAdder: MovieAdder
    let movieDatabase: MovieDatabaseProtocol

    var body: some View {
        MovieCard(posterURL: movie.posterUrl) {
            VStack(alignment: .leading,
                   spacing: 4) {
                Text(movie.title)
                Text("\(movie.year)")
            }
            .padding(16)
        }
        .onTapGesture {
            shouldPresentSheet = true
        }
        .sheet(isPresented: $shouldPresentSheet) {
            shouldPresentSheet = false
        } content: {
            let viewModel = AddMovieDetailsViewModel(imdbID: movie.id,
                                                     movieDatabase: movieDatabase)
            AddMovieDetailsView(viewModel: viewModel,
                                isPresented: $shouldPresentSheet,
                                movieAdder: self.movieAdder)
        }

    }
}

struct AddMovieCard_Previews: PreviewProvider {
    private struct Adder: MovieAdderProtocol {
        func addMovie(movie: Movie, completion: @escaping (NetworkResult<Bool>) -> Void) {
            return
        }
    }

    static var previews: some View {
        AddMovieCard(movie:
                        MockMovieDatabase.endgameSerchResults[0],
                     movieAdder: Adder(),
                     movieDatabase: MockMovieDatabase())
            .preferredColorScheme(.dark)
    }
}
