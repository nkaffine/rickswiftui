//
//  MovieSearchView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/21/21.
//

import SwiftUI

struct MovieSearchView: View {
    @ObservedObject var viewModel: MovieSearchViewModel
    @State var text: String = ""

    var body: some View {
        VStack {
            searchBar
            searchResultsView
        }
    }

    @ViewBuilder
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(UIColor.secondaryLabel))
            TextField("Search", text: $text) { isEditing in
                print(isEditing)
            } onCommit: {
                viewModel.search(forMovieWithTitle: self.text)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8.0)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .padding(.horizontal)
    }

    @ViewBuilder
    var searchResultsView: some View {
        if let searchResults = viewModel.currentSearch {
            ScrollView {
                LazyVStack {
                    ForEach(searchResults, id: \.id) { movie in
                        Text(movie.title)
                    }
                }
            }
        } else {
            Spacer()
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView(viewModel: MovieSearchViewModel())
            .preferredColorScheme(.dark)
    }
}
