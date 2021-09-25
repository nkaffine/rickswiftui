//
//  MovieWatchListContentView.swift
//  MovieWatchListContentView
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import SwiftUI

struct MovieListView<Editor: MovieListEditorProtocol>: View {
    @ObservedObject
    var viewModel: MovieListViewModel<Editor>

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            genreList
            movieList
                .padding(.trailing, 16)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 16)
    }

    private var genreList: some View {
        MovieGenreList(viewModel: viewModel)
    }

    @ViewBuilder
    private var movieList: some View {
        MovieCardList(viewModel: viewModel)
    }
}

struct MovieListView_Previews: PreviewProvider {
    class Editor: MovieListEditorProtocol {
        func markWatched(movie: Movie) {
            return
        }

        func remove(movie: Movie) {
            return
        }
    }

    static var previews: some View {
        let movies = [MockMovies.endgame, MockMovies.lionKing]
        MovieListView(viewModel: MovieListViewModel(movies: movies, editor: Editor()))
            .preferredColorScheme(.dark)
    }
}
