//
//  AddMovieCard.swift
//  AddMovieCard
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import SwiftUI

struct AddMovieCard: View {
    let movie: MovieSearchResult
    @State var shouldPresentSheet: Bool = false
    let addMovieAction: (Movie) -> Void

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
                                                     movieDatabase: MockMovieDatabase())
            AddMovieDetailsView(viewModel: viewModel,
                                isPresented: $shouldPresentSheet) { imdbID in
                addMovieAction(imdbID)
            }
        }

    }
}

struct AddMovieCard_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieCard(movie: MockMovieDatabase.endgameSerchResults[0]) { _ in
            print("Add movie tapped")
        }.preferredColorScheme(.dark)
    }
}
