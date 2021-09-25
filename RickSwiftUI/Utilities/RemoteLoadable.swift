//
//  RemoteLoadable.swift
//  RemoteLoadable
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import Foundation

enum RemoteLoadable<Data> {
    case loading
    case success(data: Data)
    case networkError(error: Error)
    case serverError(error: Error)
}
