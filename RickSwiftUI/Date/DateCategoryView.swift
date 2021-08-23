//
//  DateCategoryView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/19/21.
//

import SwiftUI

struct DateCategoryView: View {
    let categoryEmoji: String
    let categoryTitle: String
    let isActive: Bool

    var body: some View {
        if !isActive {
            VStack {
                Text(categoryEmoji).font(.system(size: 48))
                Text(categoryTitle)
            }
        } else {
            VStack {
                Text(categoryEmoji).font(.system(size: 48))
                Text(categoryTitle).fontWeight(.bold)
            }
        }
    }
}

struct DateCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DateCategoryView(categoryEmoji: "🎥", categoryTitle: "Movies", isActive: false)
            .preferredColorScheme(.dark)
        DateCategoryView(categoryEmoji: "🎥", categoryTitle: "Movies", isActive: true)
            .preferredColorScheme(.dark)
    }
}
