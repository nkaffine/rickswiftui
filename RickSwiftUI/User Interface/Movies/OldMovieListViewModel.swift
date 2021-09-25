////
////  UnwatchedMovieListViewModel.swift
////  RickSwiftUI
////
////  Created by Nicholas Kaffine on 8/25/21.
////
//
//import Foundation
//import UIKit
//
//class MovieListViewModel: ObservableObject {
//    @Published
//    private var allMovies: [MovieWithGenre]
//    private let markMovieWatchedAction: (Movie) -> Void
//    private let removeMovieAction: (Movie) -> Void
//    private let addMovieAction: () -> Void
//
//    init(movies: [Movie],
//         markMovieWatchedAction: @escaping (Movie) -> Void,
//         removeMovieAction: @escaping (Movie) -> Void,
//         addMovieAction: @escaping () -> Void) {
//        self.allMovies = movies.sorted(by: { $0.title < $1.title }).map({MovieWithGenre(movie: $0)})
//        genres = Set<String>()
//        self.markMovieWatchedAction = markMovieWatchedAction
//        self.removeMovieAction = removeMovieAction
//        self.addMovieAction = addMovieAction
//        movies.forEach { movie in
//            movie.genre.forEach { genre in
//                genres.insert(genre)
//            }
//        }
//    }
//
//    // MARK: Public Vars
//
//    var genres: Set<String>
//
//    @Published
//    var selectedGenre: String?
//
//    var movies: [MovieWithGenre] {
//        guard let currentlySelectedGenre = selectedGenre else {
//            return allMovies
//        }
//        return allMovies.filter { movie in
//            movie.genres.contains(currentlySelectedGenre)
//        }
//    }
//
//    // MARK: Intents
//
//    func selectGenre(genre: String) {
//        guard genres.contains(genre) else {
//            return
//        }
//        if selectedGenre == genre {
//            selectedGenre = nil
//        } else {
//            selectedGenre = genre
//        }
//    }
//
//    func markWatched(movie: Movie) {
//        markMovieWatchedAction(movie)
//    }
//
//    func remove(movie: Movie) {
////        removeMovieAction(movie)
//    }
//
//    func addMovie() {
//        addMovieAction()
//    }
//}
//
//
//extension MovieListViewModel {
//    struct MovieWithGenre: DisplayableMovieProtocol {
//        let id: String
//        let title: String
//        let year: String
//        let rating: String
//        let runtime: String
//        let posterURL: URL?
//        let genres: [String]
//        let plot: String
//        let streamingServices: [UIImage]
//
//        private static func image(for streamingService: StreamingPlatform) -> UIImage {
//            switch streamingService {
//                case .disney:
//                    return UIImage(named: "disney")!
//                case .netflix:
//                    return UIImage(named: "netflix")!
//                case .hbo:
//                    return UIImage(named: "hbo ")!
//                case .hulu:
//                    return UIImage(named: "hulu")!
//            }
//        }
//
//        init(movie: Movie) {
//            id = movie.imdbID
//            title = movie.title
//            year = movie.year
//            switch movie.rating {
//                case .G:
//                    rating = "G"
//                case .PG:
//                    rating = "PG"
//                case .PG13:
//                    rating = "PG-13"
//                case .R:
//                    rating = "R"
//            }
//            runtime = "\(movie.runtimeInMinutes / 60)h \(movie.runtimeInMinutes % 60)m"
//            posterURL = movie.posterUrl
//            genres = movie.genre
//            plot = movie.plot
//            streamingServices = movie.availableStreamingPlatforms.map({ streamingService in
//                MovieWithGenre.image(for: streamingService)
//            })
//        }
//    }
//}
