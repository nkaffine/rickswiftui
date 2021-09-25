//
//  MovieListViewModel.swift
//  MovieListViewModel
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import Foundation

class MovieWatchListViewModel<WatchList: WatchListProtocol>: ObservableObject, MovieListEditorProtocol where WatchList.Element == Movie {

    @Published
    var movies: RemoteLoadable<[Movie]>
    @Published
    private var model: WatchList

    init(model: WatchList) {
        self.model = model
        self.movies = .loading
    }

    // MARK: Intents

    func loadUnwatched() {
        self.movies = .loading
        model.fetchUnwatched { result in
            switch result {
                case .success(let movies):
                    self.movies = .success(data: movies)
                case .networkError(let error):
                    self.movies = .networkError(error: error)
                case .decodingError(let error), .serverError(let error):
                    self.movies = .serverError(error: error)
            }
        }
    }

    func markWatched(movie: Movie) {
        model.markWatched(element: movie) { result in
            switch result {
                case .success(let success):
                    print("\(success ? "Successfully marked as watched" : "Failed to mark as watched")")
                    DispatchQueue.main.async {
                        self.loadUnwatched()
                    }
                default:
                    print("an error occured marking watched")
            }
        }
    }

    func remove(movie: Movie) {
        self.model.remove(element: movie) { result in
            switch result {
                case .success(let success):
                    print("\(success ? "Removing movie succeed" : "Removing movie failed")")
                    DispatchQueue.main.async {
                        self.loadUnwatched()
                    }
                default:
                    print("an error occured removing")
            }
        }
    }
}
