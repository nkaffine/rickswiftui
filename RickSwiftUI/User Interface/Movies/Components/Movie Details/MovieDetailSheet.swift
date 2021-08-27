//
//  MovieDetailSheet.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct MovieDetailSheet<Content: View, Buttons: View>: View {
    let posterURL: URL?
    private let content: Content
    private let buttons: Buttons

    @ObservedObject
    private var imageLoader: ImageLoader

    init(posterURL: URL?,
         @ViewBuilder content: () -> Content,
         @ViewBuilder buttons: () -> Buttons) {
        self.posterURL = posterURL
        self.content = content()
        self.buttons = buttons()
        self.imageLoader = ImageLoader(link: posterURL?.absoluteString ?? "")
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical){
                LazyVStack(alignment: .leading, spacing: 16) {
                    poster.frame(width: geometry.size.width,
                                 height: geometry.size.width / 0.67)
                    content
                    buttons
                }
            }
        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    private var poster: some View {
        switch imageLoader.image {
            case .loading:
                ProgressView()
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: "film")
        }
    }
}

struct MovieDetailSheet_Previews: PreviewProvider {
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
        let movieDetails = DisplayableMovie(movie: movie)
        MovieDetailSheet(posterURL: movieDetails.posterURL, content: {
            MovieDetailsView(title: movieDetails.title,
                             year: movieDetails.year,
                             rating: movieDetails.rating,
                             runtime: movieDetails.runtime,
                             plot: movieDetails.plot)
        }, buttons: {
            HStack(spacing: 16) {
                StylizedButton(title: "Watched", style: .primary) {
                    print("Watched tapped")
                }
                StylizedButton(title: "Delete", style: .destructive) {
                    print("Delete tapped")
                }
            }.padding([.horizontal, .bottom], 16)
        })
            .preferredColorScheme(.dark)
    }
}
