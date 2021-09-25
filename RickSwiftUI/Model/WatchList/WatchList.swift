//
//  WatchList.swift
//  WatchList
//
//  Created by Nicholas Kaffine on 9/14/21.
//

import Foundation

struct WatchList<Element: Equatable>: WatchListProtocol {
    struct Item {
        let element: Element
        private (set) var watched: Bool

        mutating func setWatchStatus(to watched: Bool) {
            self.watched = watched
        }
    }

    private var items: [Item]

    init() {
        items = []
    }

    /// Returns the item matching the given id if one exists
    /// - Parameter id: the id to match against
    private func item(matching element: Element) -> Item? {
        return items.first { item in
            item.element == element
        }
    }

    private func index(matching element: Element) -> Array<Item>.Index? {
        return items.firstIndex { item in
            item.element == element
        }
    }

    private func items(withWatchStatus watchStatus: Bool) -> [Item] {
        return items.filter { item in
            item.watched == watchStatus
        }
    }

    mutating func add(element: Element,
                      completion: @escaping (NetworkResult<Bool>) -> Void) {
        if item(matching: element) == nil {
            items.append(Item(element: element, watched: false))
        }
        completion(.success(true))
    }

    mutating func remove(element: Element,
                         completion: @escaping (NetworkResult<Bool>) -> Void) {
        if let index = index(matching: element) {
            items.remove(at: index)
        }
        completion(.success(true))
    }

    mutating func markWatched(element: Element,
                              completion: @escaping (NetworkResult<Bool>) -> Void) {
        guard var item = item(matching: element) else {
            completion(.success(false))
            return
        }
        item.setWatchStatus(to: true)
        completion(.success(true))
    }

    mutating func markUnwatched(element: Element,
                                completion: @escaping (NetworkResult<Bool>) -> Void) {
        guard var item = item(matching: element) else {
            completion(.success(false))
            return
        }
        item.setWatchStatus(to: false)
        completion(.success(true))
    }

    func fetchUnwatched(completion: @escaping (NetworkResult<[Element]>) -> Void) {
        let unwatched = items(withWatchStatus: false)
        completion(.success(unwatched.map({$0.element})))
    }

    func fetchWatched(completion: @escaping (NetworkResult<[Element]>) -> Void) {
        let watched = items(withWatchStatus: true)
        completion(.success(watched.map({$0.element})))
    }

    func fetchAll(completion: @escaping (NetworkResult<[Item]>) -> Void) {
        completion(.success(items))
    }
}
