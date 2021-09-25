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

    private var itemsLock = NSLock()
    private var items: [Item]

    init() {
        items = []
    }

    init(elements: [Element]) {
        self.items = elements.map({Item(element: $0, watched: false)})
    }

    /// Returns the item matching the given id if one exists
    /// - Parameter id: the id to match against
    private func item(matching element: Element) -> Item? {
        items.first { item in
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
        itemsLock.lock()
        if item(matching: element) == nil {
            items.append(Item(element: element, watched: false))
        }
        itemsLock.unlock()
        DispatchQueue.global(qos: .userInitiated).async {
            completion(.success(true))
        }
    }

    mutating func remove(element: Element,
                         completion: @escaping (NetworkResult<Bool>) -> Void) {
        itemsLock.lock()
        if let index = index(matching: element) {
            items.remove(at: index)
        }
        itemsLock.unlock()
        DispatchQueue.global(qos: .userInitiated).async {
            completion(.success(true))
        }
    }

    mutating func markWatched(element: Element,
                              completion: @escaping (NetworkResult<Bool>) -> Void) {
        itemsLock.lock()
        guard var item = item(matching: element) else {
            completion(.success(false))
            return
        }
        itemsLock.unlock()
        item.setWatchStatus(to: true)
        DispatchQueue.global(qos: .userInitiated).async {
            completion(.success(true))
        }
    }

    mutating func markUnwatched(element: Element,
                                completion: @escaping (NetworkResult<Bool>) -> Void) {
        itemsLock.lock()
        guard var item = item(matching: element) else {
            completion(.success(false))
            return
        }
        item.setWatchStatus(to: false)
        itemsLock.unlock()
        DispatchQueue.global(qos: .userInitiated).async {
            completion(.success(true))
        }
    }

    func fetchUnwatched(completion: @escaping (NetworkResult<[Element]>) -> Void) {
        itemsLock.lock()
        let unwatched = items(withWatchStatus: false)
        let unwatchedElements = unwatched.map({$0.element})
        itemsLock.unlock()
        DispatchQueue.global(qos: .userInitiated).async {
            completion(.success(unwatchedElements))
        }
    }

    func fetchWatched(completion: @escaping (NetworkResult<[Element]>) -> Void) {
        itemsLock.lock()
        let watched = items(withWatchStatus: true)
        itemsLock.unlock()
        DispatchQueue.global(qos: .userInitiated).async {
            completion(.success(watched.map({$0.element})))
        }
    }

    func fetchAll(completion: @escaping (NetworkResult<[Item]>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            completion(.success(items))
        }
    }
}
