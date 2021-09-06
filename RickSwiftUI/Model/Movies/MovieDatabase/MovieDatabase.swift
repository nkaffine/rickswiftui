//
//  MovieSearchMovieDatabaseAPI.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/23/21.
//

import Foundation

class MovieDatabase: MovieDatabaseProtocol {
    enum InformationErrors: Error {
        case unableToParseServerResult
    }

    private let searchAPI = MovieDatabaseSearchAPI()
    private let informationAPI = MovieDatabaseInformationAPI()

    struct SearchResult: MovieSearchResult {
        let title: String
        let id: String
        let posterUrl: URL?
        let year: String

        init(result: MovieDatabaseSearchResult.Movie) {
            self.title = result.title
            self.id = result.id
            self.posterUrl = URL(string: result.posterUrl)
            self.year = result.year
        }
    }

    struct InformationResult: MovieInformationResult {
        let imdbID: String
        let title: String
        let year: String
        let rating: MovieRating
        let runtimeInMinutes: Int
        let genre: [String]
        let plot: String
        let posterUrl: URL?

        private static func parseRating(from rating: String) -> MovieRating? {
            switch rating {
                case "G":
                    return .G
                case "PG":
                    return .PG
                case "PG-13":
                    return .PG13
                case "R":
                    return .R
                default:
                    return nil
            }
        }

        init?(imdbID: String, movie: MovieDatabaseInformationResult) {
            guard let rating = InformationResult.parseRating(from: movie.rating),
                  let runtimeInMinutes = RuntimeParser.parseRuntimeInMinutes(from: movie.runtime) else {
                return nil
            }
            self.imdbID = imdbID
            self.title = movie.title
            self.year = movie.year
            self.rating = rating
            self.runtimeInMinutes = runtimeInMinutes
            self.genre = GenreParser.parseGenres(from: movie.genre)
            self.plot = movie.plot
            self.posterUrl = URL(string: movie.poster)
        }
    }

    func search(forMovieWithTitle title: String, completion: @escaping (NetworkResult<[MovieSearchResult]>) -> Void) {
        searchAPI.search(forMovieWithTitle: title) { result in
            switch result {
                case .success(let movies):
                    completion(.success(movies.map({SearchResult(result: $0)})))
                case .serverError(let error):
                    completion(.serverError(error))
                case .decodingError(let error):
                    completion(.decodingError(error))
                case .networkError(let error):
                    completion(.networkError(error))
            }
        }
    }

    func information(forMovieWithID imdbID: String, completion: @escaping (NetworkResult<MovieInformationResult>) -> Void) {
        informationAPI.getInformationForMovie(withImdbID: imdbID) { result in
            switch result {
                case .success(let data):
                    if let movieInformation = InformationResult(imdbID: imdbID, movie: data) {
                        completion(.success(movieInformation))
                    } else {
                        completion(.decodingError(InformationErrors.unableToParseServerResult))
                    }
                case .networkError(let error):
                    completion(.networkError(error))
                case .decodingError(let error):
                    completion(.decodingError(error))
                case .serverError(let error):
                    completion(.serverError(error))
            }
        }
    }
}

//struct MovieSearchMovieDatabaseAPI: MovieDatabaseProtocol {
//    struct MovieResult: MovieSearchResult {
//        let title: String
//        let id: String
//        let posterUrl: URL?
//        let year: String
//        init(searchResult: MovieDatabaseSearchResult.Movie) {
//            self.title = searchResult.title
//            self.id = searchResult.id
//            self.posterUrl = URL(string: searchResult.posterUrl)
//            self.year = searchResult.year
//        }
//    }
//    var movieDatabaseAPI = MovieDatabaseAPI()
//    func search(forMovieWithTitle title: String,
//                completion: @escaping (NetworkResult<[MovieSearchResult]>) -> Void) {
//        movieDatabaseAPI.search(forMovieWithTitle: title) { result in
//            switch result {
//                case .success(let movies):
//                    let convertedMovies: [MovieResult] = movies.map({MovieResult(searchResult: $0)})
//                    completion(.success(convertedMovies))
//                case .serverError(let error):
//                    completion(.serverError(error))
//                case .networkError(let error):
//                    completion(.networkError(error))
//                case .decodingError(let error):
//                    completion(.decodingError(error))
//            }
//        }
//    }
//
//    func information(forMovieWithID imdbID: String,
//                     completion: @escaping (NetworkResult<MovieInformationResult>) -> Void) {
//    }
//}
