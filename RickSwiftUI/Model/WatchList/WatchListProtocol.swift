//
//  WatchList.swift
//  WatchList
//
//  Created by Nicholas Kaffine on 9/6/21.
//

import Foundation

protocol WatchListProtocol {
    associatedtype Element where Element: Equatable
    // MARK: List Editing

    /// Adds a movie to the watch list. Calls the completion handler with success if the element was added or was already in the list.
    /// - Parameters:
    ///    - element the element ot be added
    ///    - completion called with the result of the network call
    mutating func add(element: Element,
                      completion: @escaping (NetworkResult<Bool>) -> Void)

    /// Removes an element from the watch list. Calls the completion handler with success if the element is removed from the list or the element was not in the list to begin with.
    /// - Parameters:
    ///    - element the element to be added to the list
    ///    - completion called with the result of the network call
    mutating func remove(element: Element,
                         completion: @escaping (NetworkResult<Bool>) -> Void)

    /// Marks a element as watched. Calls the completion handler with successful when the element is marked as watched or the element is already marked as watched.
    /// - Parameters:
    ///    - element the element to be marked watched
    ///    - completion called with whether the call ws successful
    mutating func markWatched(element: Element,
                              completion: @escaping (NetworkResult<Bool>) -> Void)

    /// Marks an element as unwatched. Calls the completion handler with success when the element is marked as unwatched or is already unwatched.
    /// - Parameters:
    ///    - element the element to be marked as unwatched
    ///    - completion called with whether the call was successful
    mutating func markUnwatched(element: Element,
                                completion: @escaping (NetworkResult<Bool>) -> Void)

    // MARK: List Querying

    /// Fetches the list of unwatched elements and calls the completion with the result
    /// - Parameter completion the completion that will be called with the fetched data
    func fetchUnwatched(completion: @escaping (NetworkResult<[Element]>) -> Void)

    /// Fetches the list of watched elements and calls the completion with the result
    /// - Parameter completion the completion that will be called with the fetched data
    func fetchWatched(completion: @escaping (NetworkResult<[Element]>) -> Void)
}
