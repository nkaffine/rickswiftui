//
//  MovieCardDetailsViewModel.swift
//  MovieCardDetailsViewModel
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import Foundation

class ModifiableMovieCardViewModel: ModifiableMovieCardViewModelProtocol {
    private let primaryActionClosure: () -> Void
    private let secondaryActionClosure: () -> Void

    init(movie: Movie,
         primaryActionTitle: String,
         secondaryActionTitle: String,
         primaryAction: @escaping () -> Void,
         secondaryAction: @escaping () -> Void) {
        self.movie = movie
        self.primaryActionTitle = primaryActionTitle
        self.secondaryActionTitle = secondaryActionTitle
        self.primaryActionClosure = primaryAction
        self.secondaryActionClosure = secondaryAction
    }

    let primaryActionTitle: String
    let secondaryActionTitle: String
    var movie: Movie

    var title: String {
        return self.movie.title
    }
    var year: String {
        return self.movie.year
    }
    var rating: String {
        // TODO: Make rating just have a string raw value
        switch self.movie.rating {
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
        let hours = movie.runtimeInMinutes / 60
        let minutes = movie.runtimeInMinutes % 60
        return "\(hours)h \(minutes)m"
    }
    var plot: String {
        return movie.plot
    }
    var posterURL: URL? {
        return movie.posterUrl
    }
    func primaryAction() {
        self.primaryActionClosure()
    }
    func secondaryAction() {
        self.secondaryActionClosure()
    }
}
