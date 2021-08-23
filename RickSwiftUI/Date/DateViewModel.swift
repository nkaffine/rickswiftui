//
//  DateViewModel.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/19/21.
//

import Foundation

class DateViewModel: ObservableObject {
    private static func createModel() -> DateModel {
        let categories = [DateModel.DateCategory(title: "Movies", emoji: "🎥"),
                          DateModel.DateCategory(title: "Cooking", emoji: "🍳"),
                          DateModel.DateCategory(title: "Baking", emoji: "🎂"),
                          DateModel.DateCategory(title: "Restaurants", emoji: "🍽"),
                          DateModel.DateCategory(title: "Misc", emoji: "📅")]
        return DateModel(categories: categories)
    }

    @Published
    private var model: DateModel = DateViewModel.createModel()

    var categories: [DateModel.DateCategory] {
        return model.categories
    }
}
