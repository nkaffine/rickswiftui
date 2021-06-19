//
//  CounterViewModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/15/21.
//

import Foundation

class CounterViewModel: ObservableObject {
    private static var mockCounters: [HomeModel.CounterInfo] = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return [
            HomeModel.CounterInfo(date: dateFormatter.date(from: "09/10/2020")!,
                                  title: "Time since dating", id: 0),
            HomeModel.CounterInfo(date: dateFormatter.date(from: "06/30/2021")!,
                                  title: "Time to seeing each other", id: 1),
            HomeModel.CounterInfo(date: dateFormatter.date(from: "09/10/2021")!,
                                  title: "Time to 1 year anniversary", id: 2)
        ]
    }()

    @Published private var homeModel: HomeModel = HomeModel(counters: CounterViewModel.mockCounters)

    struct CountDate: Identifiable {
        let id: Int
        let title: String
        let date: Date
    }

    var dates: [CountDate] {
        return homeModel.counters.map { counterInfo -> CountDate in
            return CountDate(id: counterInfo.id, title: counterInfo.title, date: counterInfo.date)
        }
    }
}
