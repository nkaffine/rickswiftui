//
//  MovieDatabaseInformationResult.swift
//  MovieDatabaseInformationResult
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import Foundation

struct MovieDatabaseInformationResult: Decodable {
    let title: String
    let year: String
    let rating: String
    let runtime: String
    let genre: String
    let plot: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rating = "Rated"
        case runtime = "Runtime"
        case genre = "Genre"
        case plot = "Plot"
        case poster = "Poster"
    }
}
