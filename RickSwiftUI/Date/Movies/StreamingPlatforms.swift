//
//  StreamingPlatforms.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/19/21.
//

import SwiftUI

enum StreamingPlatform {
    case disney
    case netflix
    case hbo
    case hulu

    var image: Image {
        switch self {
            case .disney:
                return Image("disney")
            case .netflix:
                return Image("netflix")
            case .hbo:
                return Image("hbo")
            case .hulu:
                return Image("hulu")
        }
    }
}
