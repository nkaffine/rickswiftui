//
//  MovieListViewModel.swift
//  MovieListViewModel
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import Foundation

protocol MovieListEditorProtocol {
    func markWatched(movie: Movie)
    func remove(movie: Movie)
}

class MovieListViewModel<Editor: MovieListEditorProtocol>: MovieGenreListViewModelProtocol {
    private let movieList: [Movie]
    let genres: [String]
    private var editor: Editor

    @Published
    private (set) var selectedGenre: String?

    init(movies: [Movie], editor: Editor) {
        self.editor = editor
        self.movieList = movies
        self.selectedGenre = nil
        var genres = Set<String>()
        movies.forEach { movie in
            movie.genre.forEach { genre in
                genres.insert(genre)
            }
        }
        self.genres = genres.sorted()
    }

    var movies: [Movie] {
        guard let selectedGenre = selectedGenre else {
            return movieList
        }
        let moviesWithGenre = movieList.filter { movie in
            movie.genre.contains(selectedGenre)
        }
        return moviesWithGenre
    }

    // MARK: Intents

    func select(genre: String) {
        guard let selectedGenre = selectedGenre else {
            self.selectedGenre = genre
            return
        }
        if selectedGenre == genre {
            self.selectedGenre = nil
        } else {
            self.selectedGenre = genre
        }
    }
}

extension MovieListViewModel: MovieCardListViewModelProtocol {
    func markWatched(movie: Movie) {
        self.editor.markWatched(movie: movie)
    }

    func remove(movie: Movie) {
        self.editor.remove(movie: movie)
    }
}
