//
//  MovieCard.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/24/21.
//

import SwiftUI

struct MovieCard: View {
    let title: String
    let runtime: String
    let rating: String
    let year: String
    let posterURL: URL?
    let movieWatchedAction: () -> Void
    let movieDeleteAction: () -> Void
    @State private var isPresentingSheet: Bool = false

    var body: some View {
        VStack(alignment: .leading,
               spacing: Constants.moviePosterAndDetailVerticalSpacing) {
            PosterImage(posterURL: posterURL)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.posterImageHeight)
                .clipped()
            movieDetails
        }
               .contentShape(Rectangle())
               .background(Color(UIColor.secondarySystemBackground))
               .cornerRadius(Constants.cornerRadius)
               .onTapGesture {
                   isPresentingSheet = true
               }
               .sheet(isPresented: $isPresentingSheet) {
                   isPresentingSheet = false
               } content: {
                   // TODO: add streaming services and plot
                   MovieDetailSheet(posterURL: posterURL,
                                    streamingServices: [],
                                    title: title,
                                    rating: rating,
                                    year: year,
                                    runtime: runtime,
                                    plot: "This is a plot",
                                    watchedAction: {
                       movieWatchedAction()
                   }, deleteAction: {
                       movieDeleteAction()
                   },
                                    isPresented: $isPresentingSheet)
               }

    }

    private var movieDetails: some View {
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
        static let posterImageHeight: CGFloat = 136
        static let movieDetailPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 16
        static let moviePosterAndDetailVerticalSpacing: CGFloat = 0
        static let movieDetailsVerticalSpacing: CGFloat = 4
    }
}

private struct PosterImage: View {
    let posterURL: URL?
    @ObservedObject
    private var imageLoader: ImageLoader

    init(posterURL: URL?) {
        self.posterURL = posterURL
        self.imageLoader = ImageLoader(link: posterURL?.absoluteString ?? "")
    }

    var body: some View {
        switch imageLoader.image {
            case .failure:
                posterPlaceholder
            case .loading:
                ProgressView()
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
        }
    }

    private var posterPlaceholder: some View {
        Image(uiImage: UIImage(systemName: "film")!)
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MockMovieDatabaseAPI.endgameInformation
        MovieCard(title: movie.title,
                  runtime: "3h 1m",
                  rating: "PG-13",
                  year: movie.year,
                  posterURL: movie.posterUrl, movieWatchedAction: {
            print("Movie watched tapped")
        }, movieDeleteAction: {
            print("Movie deleted tapped")
        })
            .preferredColorScheme(.dark)
    }
}
