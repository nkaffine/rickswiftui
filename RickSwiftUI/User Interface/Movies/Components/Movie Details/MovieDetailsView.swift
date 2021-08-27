//
//  MovieDetails.swift
//  MovieDetails
//
//  Created by Nicholas Kaffine on 8/26/21.
//

import SwiftUI

struct MovieDetailsView: View {
    let title: String
    let year: String
    let rating: String
    let runtime: String
    let plot: String

    var body: some View {
        VStack(alignment: .leading,
               spacing: 16) {
            Text(title).font(.title3.bold())
            HStack(alignment: .center, spacing: 16) {
                Text(year)
                Text(rating)
                Text(runtime)
            }
            .font(.subheadline)
            Text(plot).font(.body)
        }
               .padding(.horizontal, 16)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    private static func rating(from movie: Movie) -> String {
        switch movie.rating {
            case .G:
                return "G"
            case .PG:
                return "PG"
            case .PG13:
                return "PG-13"
            case .R:
                return "R"
        }
    }

    static var previews: some View {
        let movie = MockMovies.endgame
        let runtime = "\(movie.runtimeInMinutes / 60)h \(movie.runtimeInMinutes % 60)m"
        MovieDetailsView(title: movie.title,
                     year: movie.year,
                     rating: rating(from: movie),
                     runtime: runtime,
                     plot: movie.plot)
            .preferredColorScheme(.dark)
    }
}
