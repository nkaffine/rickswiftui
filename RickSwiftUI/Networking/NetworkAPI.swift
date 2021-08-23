//
//  NetworkManager.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/21/21.
//

import Foundation

enum NetworkResult<Data> {
    case success(Data)
    case networkError(Error)
    case serverError(Error)
    case decodingError(Error)
}

protocol NetworkAPI {
    associatedtype APIData: Decodable

    var baseUrl: String { get }
    var headers: [String: String]? { get }
}

extension NetworkAPI {
    func get(withParameters parameters: [URLQueryItem]?, completion: @escaping (NetworkResult<APIData>) -> ()) {
        var url = URLComponents(string: baseUrl)!
        url.queryItems = parameters
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.networkError(error))
            } else {
                do {
                    let result: APIData = try JSONDecoder().decode(APIData.self, from: data!)
                    completion(.success(result))
                } catch let error {
                    completion(.decodingError(error))
                }
            }
        }
        dataTask.resume()
    }
}
