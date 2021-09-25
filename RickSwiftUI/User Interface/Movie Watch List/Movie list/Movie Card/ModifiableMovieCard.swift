//
//  ModifiableMovieCard.swift
//  ModifiableMovieCard
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import SwiftUI

protocol ModifiableMovieCardViewModelProtocol: MovieDetailsViewModelProtocol {
    var movie: Movie { get }
    var primaryActionTitle: String { get }
    var secondaryActionTitle: String { get }
    func primaryAction()
    func secondaryAction()
}

struct ModifiableMovieCard<ViewModel: ModifiableMovieCardViewModelProtocol>: View {
    @ObservedObject
    var viewModel: ViewModel
    @State var isPresenting: Bool = false

    var body: some View {
        let posterUrl = viewModel.posterURL
        MovieCard(posterURL: posterUrl) {
            MovieCardDetails(title: viewModel.title,
                             year: viewModel.year,
                             rating: viewModel.rating,
                             runtime: viewModel.runtime)
        } .onTapGesture {
            self.isPresenting = true
        }.sheet(isPresented: $isPresenting) {
            self.isPresenting = false
        } content: {
            MovieListDetailSheet(viewModel: viewModel,
                                 isPresented: $isPresenting)
        }

    }
}

struct ModifiableMovieCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ModifiableMovieCardViewModel(movie: MockMovies.endgame,
                                                     primaryActionTitle: "Add Movie", secondaryActionTitle: "Cancel") {
            return
        } secondaryAction: {
            return
        }
        ModifiableMovieCard(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
