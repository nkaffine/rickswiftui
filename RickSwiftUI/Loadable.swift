//
//  Loadable.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/24/21.
//

import Foundation

enum Loadable<Data> {
    case loading
    case success(Data)
    case failure(Error)
}
