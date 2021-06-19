//
//  HomeModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/15/21.
//

import Foundation

struct HomeModel {
    struct CounterInfo: Identifiable {
        let date: Date
        let title: String
        let id: Int
    }

    let counters: [CounterInfo]
}
