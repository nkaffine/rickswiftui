//
//  GenreParser.swift
//  GenreParser
//
//  Created by Nicholas Kaffine on 9/6/21.
//

import Foundation

struct GenreParser {
    /// Converts a string of comma separated string into an array of strings removing the trailing and leading whitespace from genres.
    static func parseGenres(from genreString: String) -> [String] {
        let genres = genreString.split(separator: ",")
        let noLeadingOrTrailingSpaceGenres = genres.map { genreString in
            String(genreString).removingLeadingWhiteSpace().removingTrailingWhiteSpace()
        }
        return noLeadingOrTrailingSpaceGenres
    }
}
