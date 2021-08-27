//
//  DisplayableMovie.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import Foundation
import UIKit

protocol DisplayableMovieProtocol: Identifiable {
    var id: String { get }
    var title: String { get }
    var year: String { get }
    var rating: String { get }
    var runtime: String { get }
    var posterURL: URL? { get }
    var plot: String { get }
    var streamingServices: [UIImage] { get }
}
