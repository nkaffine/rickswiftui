//
//  MovieInformationFetcherProtocol.swift
//  MovieInformationFetcherProtocol
//
//  Created by Nicholas Kaffine on 9/14/21.
//

import Foundation

protocol MovieInformationFetcherProtocol {
    func fetch(movieWithID id: String,
               completion: @escaping (NetworkResult<MovieInformationResult>) -> Void)
}
