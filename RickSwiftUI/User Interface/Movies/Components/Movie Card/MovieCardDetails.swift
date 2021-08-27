//
//  MovieCardDetails.swift
//  MovieCardDetails
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import SwiftUI

struct MovieCardDetails: View {
    let title: String
    let year: String
    let rating: String
    let runtime: String

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.movieDetailsVerticalSpacing) {
            Text(title)
                .font(.headline.bold())
            Text(movieDetailString)
                .font(.subheadline)
        }
        .padding(Constants.movieDetailPadding)
    }

    private var movieDetailString: String {
        return "\(year) | \(rating) | \(runtime)"
    }

    private struct Constants {
        static let movieDetailPadding: CGFloat = 16
        static let movieDetailsVerticalSpacing: CGFloat = 4
    }
}

struct MovieCardDetails_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MockMovies.endgame
        let movieDetails = DisplayableMovie(movie: movie)
        MovieCardDetails(title: movieDetails.title,
                         year: movieDetails.year,
                         rating: movieDetails.rating,
                         runtime: movieDetails.runtime)
    }
}
