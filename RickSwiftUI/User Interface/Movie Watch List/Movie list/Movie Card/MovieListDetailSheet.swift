//
//  MovieListDetailSheet.swift
//  MovieListDetailSheet
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import SwiftUI

protocol MovieDetailsViewModelProtocol: ObservableObject {
    var title: String { get }
    var year: String { get }
    var rating: String { get }
    var runtime: String { get }
    var plot: String { get }
    var posterURL: URL? { get }
    var primaryActionTitle: String { get }
    var secondaryActionTitle: String { get }
    func primaryAction()
    func secondaryAction()
}

struct MovieListDetailSheet<ViewModel: MovieDetailsViewModelProtocol>: View {
    @ObservedObject
    var viewModel: ViewModel
    @Binding var isPresented: Bool

    @ObservedObject
    private var imageLoader: ImageLoader

    init(viewModel: ViewModel,
         isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        imageLoader = ImageLoader(link: viewModel.posterURL?.absoluteString ?? "")
        self._isPresented = isPresented
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 16) {
                    poster.frame(width: geometry.size.width,
                                 height: geometry.size.width / 0.67)
                    MovieDetailsView(title: viewModel.title,
                                     year: viewModel.year,
                                     rating: viewModel.rating,
                                     runtime: viewModel.runtime,
                                     plot: viewModel.plot)
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
            StylizedButton(title: viewModel.primaryActionTitle,
                           style: .primary) {
                viewModel.primaryAction()
                isPresented = false
            }
            StylizedButton(title: viewModel.secondaryActionTitle,
                           style: .secondary) {
                viewModel.secondaryAction()
                isPresented = false
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 32)
    }
}

struct MovieListDetailSheet_Previews: PreviewProvider {
    class ViewModel: MovieDetailsViewModelProtocol {
        private let movie: Movie

        init(movie: Movie) {
            self.movie = movie
        }

        var title: String {
            movie.title
        }

        var year: String {
            movie.year
        }

        var rating: String {
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

        var runtime: String {
            return "\(movie.runtimeInMinutes / 60)h \(movie.runtimeInMinutes % 60)m"
        }

        var plot: String {
            return movie.plot
        }

        var posterURL: URL? {
            return movie.posterUrl
        }

        var primaryActionTitle: String {
            return "Add Movie"
        }

        var secondaryActionTitle: String {
            return "Cancel"
        }

        func primaryAction() {
            return
        }

        func secondaryAction() {
            return
        }
    }

    @State static var isPresented = false

    static var previews: some View {
        let movie = MockMovies.endgame
        let viewModel = ViewModel(movie: movie)

        MovieListDetailSheet(viewModel: viewModel, isPresented: $isPresented)
            .preferredColorScheme(.dark)
    }
}
