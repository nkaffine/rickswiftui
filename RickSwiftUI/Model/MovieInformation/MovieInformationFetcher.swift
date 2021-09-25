//
//  MovieInformationFetchd.swift
//  MovieInformationFetchd
//
//  Created by Nicholas Kaffine on 9/14/21.
//

import Foundation

class MovieInformationFetcher: MovieInformationFetcherProtocol {
    enum Errors: Error {
        case decodingError
    }

    private let service = MovieDatabaseInformationAPI()

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

    func fetch(movieWithID id: String,
               completion: @escaping (NetworkResult<MovieInformationResult>) -> Void) {
        service.getInformationForMovie(withImdbID: id) { result in
            switch result {
                case .success(let movieInformationResult):
                    if let adaptedInformationResult =
                        InformationResult(imdbID: id,
                                          movie: movieInformationResult) {
                        completion(.success(adaptedInformationResult))
                    } else {
                        completion(.decodingError(Errors.decodingError))
                    }
                case .decodingError(let decodingError):
                    completion(.decodingError(decodingError))
                case .networkError(let networkError):
                    completion(.networkError(networkError))
                case .serverError(let serverError):
                    completion(.serverError(serverError))
            }
        }
    }
}
