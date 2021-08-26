//
//  MovieDetailSheet.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct MovieDetailSheet<MovieDetails: DisplayableMovie>: View {
    let details: MovieDetails
    let watchedAction: () -> Void
    let deleteAction: () -> Void
    @Binding var isPresented: Bool

    @ObservedObject
    private var imageLoader: ImageLoader

    init(details: MovieDetails,
         watchedAction: @escaping () -> Void,
         deleteAction: @escaping () -> Void,
         isPresented: Binding<Bool>) {
        self.details = details
        imageLoader = ImageLoader(link: details.posterURL?.absoluteString ?? "")
        self.watchedAction = watchedAction
        self.deleteAction = deleteAction
        self._isPresented = isPresented
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 16) {
                    poster.frame(width: geometry.size.width,
                                 height: geometry.size.width / 0.67)
//                    MovieDetails(title: details.title,
//                                 year: details.year,
//                                 rating: details.rating,
//                                 runtime: details.runtime,
//                                 plot: details.plot)
                    buttonStack
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

    private var buttonStack: some View {
        HStack(spacing: 16) {
            StylizedButton(title: "Watched",
                           style: .primary) {
                watchedAction()
                isPresented = false
            }
            StylizedButton(title: "Delete",
                           style: .destructive) {
                deleteAction()
                isPresented = false
            }
        }
        .padding([.horizontal, .bottom], 16)
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
        let runtime = "\(movie.runtimeInMinutes / 60)h \(movie.runtimeInMinutes % 60)m"

        MovieDetailSheet(posterURL: movie.posterUrl,
                         streamingServices: [],
                         title: movie.title,
                         rating: rating(from: movie),
                         year: movie.year,
                         runtime: runtime,
                         plot: movie.plot, watchedAction: {
            print("Watched tapped")
        }, deleteAction: {
            print("delete tapped")
        }, isPresented: .constant(true))
            .preferredColorScheme(.dark)
    }
}
