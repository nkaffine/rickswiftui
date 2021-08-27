//
//  MovieCrd.swift
//  MovieCrd
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import SwiftUI

struct MovieCard<DetailsView: View>: View {
    let posterURL: URL?
    let detailsView: DetailsView

    init(posterURL: URL?, @ViewBuilder detailsView: () -> DetailsView) {
        self.posterURL = posterURL
        self.detailsView = detailsView()
    }

    var body: some View {
        VStack(alignment: .leading,
               spacing: Constants.moviePosterAndDetailVerticalSpacing) {
            PosterImage(posterURL: posterURL)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.posterImageHeight)
                .clipped()
            detailsView
        }
           .contentShape(Rectangle())
           .background(Color(UIColor.secondarySystemBackground))
           .cornerRadius(Constants.cornerRadius)
    }
}

private struct Constants {
    static let posterImageHeight: CGFloat = 136
    static let cornerRadius: CGFloat = 16
    static let moviePosterAndDetailVerticalSpacing: CGFloat = 0
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MockMovies.endgame
        let movieDetails = DisplayableMovie(movie: movie)
        MovieCard(posterURL: movieDetails.posterURL, detailsView: {
            MovieCardDetails(title: movieDetails.title,
                             year: movieDetails.year,
                             rating: movieDetails.rating,
                             runtime: movieDetails.runtime)
        })
            .preferredColorScheme(.dark)
    }
}
