//
//  GenreItem.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct GenreItem: View {
    let genre: String
    let isSelected: Bool

    var body: some View {
        Text(genre)
            .font(.headline)
            .fontWeight(fontWeight)
            .padding(8)
            .background(Color(UIColor.secondarySystemFill))
            .cornerRadius(8)
    }

    private var fontWeight: Font.Weight {
        return isSelected ? .bold : .regular
    }
}

struct GenreItem_Previews: PreviewProvider {
    static var previews: some View {
        GenreItem(genre: "Action", isSelected: false)
            .preferredColorScheme(.dark)
    }
}
