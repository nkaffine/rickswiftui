//
//  MovieGenreList.swift
//  MovieGenreList
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import SwiftUI

protocol MovieGenreListViewModelProtocol: ObservableObject {
    var genres: [String] { get }
    var selectedGenre: String? { get }
    func select(genre: String)
}

struct MovieGenreList<ViewModel: MovieGenreListViewModelProtocol>: View {
    @ObservedObject
    var viewModel: ViewModel

    var body: some View {
        ScrollView(.horizontal,
                   showsIndicators: false) {
            LazyHStack(alignment: .center, spacing: 8) {
                ForEach(viewModel.genres, id: \.self) { genre in
                    GenreItem(genre: genre,
                              isSelected: genre == viewModel.selectedGenre)
                        .onTapGesture {
                            viewModel.select(genre: genre)
                        }
                }
            }
        }.fixedSize(horizontal: false,
                    vertical: true)
    }
}

struct MovieGenreList_Previews: PreviewProvider {
    private class ViewModel: MovieGenreListViewModelProtocol {
        init(genres: [String]) {
            self.genres = genres
            self.selectedGenre = nil
        }

        var genres: [String]

        @Published
        var selectedGenre: String?

        func select(genre: String) {
            self.selectedGenre = genre
        }
    }

    static var previews: some View {
        let genres = ["Comedy", "Drama", "Action", "Adventure"]
        let viewModel = ViewModel(genres: genres)
        MovieGenreList(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
