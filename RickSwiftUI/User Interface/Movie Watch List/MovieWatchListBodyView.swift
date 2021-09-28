//
//  MovieWatchListBodyView.swift
//  MovieWatchListBodyView
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import SwiftUI

struct MovieWatchListBodyView<WatchList: WatchListProtocol>: View where WatchList.Element == Movie {
    @ObservedObject
    var viewModel: MovieWatchListViewModel<WatchList>

    var body: some View {
        switch viewModel.movies {
            case .loading:
                MovieWatchListLoadingView()
            case .success(data: let movies):
                MovieListView(viewModel: MovieListViewModel(movies: movies, editor: viewModel))
            case .networkError:
                MoviewWatchListNetworkErrorView()
            case .serverError:
                MovieWatchListServerErrorView()
        }
    }
}

struct MovieWatchListBodyView_Previews: PreviewProvider {
    static var previews: some View {
        let watchList = WatchList<String>(elements: ["tt4154796", "tt0110357", "tt2582802", "tt0338013", "tt0485947"])
        let model = MovieWatchList(movieFetcher: MovieInformationFetcher(),
                                   idWatchList: watchList)
        let viewModel = MovieWatchListViewModel(model: model)
        MovieWatchListBodyView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
