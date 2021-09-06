//
//  AddMovieView.swift
//  AddMovieView
//
//  Created by Nicholas Kaffine on 8/26/21.
//

import SwiftUI

struct AddMovieView: View {
    @State var searchText: String = ""
    @ObservedObject
    private var searcher: AddMovieSearcher = AddMovieSearcher(movieDatabase: MockMovieDatabase())
    let addMovieAction: (String) -> Void

    var body: some View {
        VStack(spacing: 16) {
            searchBar
            searchResult
            Spacer()
        }
        .padding(16)
    }

    @ViewBuilder
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(UIColor.secondaryLabel))
            TextField("Search", text: $searchText) { isEditing in
                print(isEditing)
            } onCommit: {
                searcher.searchForMovies(withTitle: searchText)
            }
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(Color(UIColor.secondaryLabel))
                .onTapGesture {
                    searchText = ""
                }
        }
        .padding(.horizontal)
        .padding(.vertical, 8.0)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
    }

    @ViewBuilder
    private var searchResult: some View {
        switch searcher.movies {
            case .loading:
                ProgressView()
            case .success(let movies):
                movieList(for: movies)
            case .failure:
                Text("Something went wrong")
        }
    }

    private func movieList(for movies: [MovieSearchResult]) -> some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(movies, id: \.id) { movie in
                    AddMovieCard(movie: movie) { imdbID in
                        addMovieAction(imdbID)
                    }
                }
            }
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieView(addMovieAction: { imdbID in
            print("Add movie tapped")
        })
            .preferredColorScheme(.dark)
    }
}
