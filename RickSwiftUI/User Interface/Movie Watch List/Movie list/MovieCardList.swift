//
//  MovieCardList.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

protocol MovieCardListViewModelProtocol: ObservableObject {
    var movies: [Movie] { get }
    func markWatched(movie: Movie)
    func remove(movie: Movie)
}

struct MovieCardList<ViewModel: MovieCardListViewModelProtocol>: View {
    @ObservedObject
    var viewModel: ViewModel

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: Constants.movieListVerticalSpacing) {
                ForEach(viewModel.movies, id: \.imdbID) { movie in
                    let viewModel = ModifiableMovieCardViewModel(movie: movie, primaryActionTitle: "Mark Watched", secondaryActionTitle: "Delete") {
                        self.viewModel.markWatched(movie: movie)
                    } secondaryAction: {
                        self.viewModel.remove(movie: movie)
                    }
                    ModifiableMovieCard(viewModel: viewModel)
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
    class ViewModel: MovieCardListViewModelProtocol {
        init(movies: [Movie]) {
            self.movies = movies
        }

        var movies: [Movie]

        func markWatched(movie: Movie) {
            return
        }

        func remove(movie: Movie) {
            return
        }


    }

    static var previews: some View {
        let movies = [MockMovies.endgame,
                      MockMovies.lionKing]
        let viewModel = ViewModel(movies: movies)
        MovieCardList(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
