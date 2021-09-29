//
//  AddMovieView.swift
//  AddMovieView
//
//  Created by Nicholas Kaffine on 8/26/21.
//

import SwiftUI

protocol MovieAdderProtocol {
    func addMovie(movie: Movie, completion: @escaping (NetworkResult<Bool>) -> Void)
    func didFinishAddingMovie()
}

struct AddMovieView<MovieAdder: MovieAdderProtocol>: View {
    @State var searchText: String = ""
    @ObservedObject
    private var searcher: AddMovieSearcher
    private let movieAdder: MovieAdder
    private let movieDatabase: MovieDatabaseProtocol

    init(movieAdder: MovieAdder,
         movieDatabase: MovieDatabaseProtocol) {
        self.movieAdder = movieAdder
        self.movieDatabase = movieDatabase
        self.searcher = AddMovieSearcher(movieDatabase: movieDatabase)
    }

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
                    AddMovieCard(movie: movie,
                                 movieAdder: self.movieAdder,
                                 movieDatabase: self.movieDatabase)
                }
            }
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    private struct Adder: MovieAdderProtocol {
        func addMovie(movie: Movie, completion: @escaping (NetworkResult<Bool>) -> Void) {
            return
        }
        func didFinishAddingMovie() {
            return
        }
    }

    static var previews: some View {
        AddMovieView(movieAdder: Adder(),
                     movieDatabase: MockMovieDatabase())
            .preferredColorScheme(.dark)
    }
}
