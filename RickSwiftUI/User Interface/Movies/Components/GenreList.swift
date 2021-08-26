//
//  GenreList.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct GenreList: View {
    let genres: [String]
    let selectedGenres: [String]
    let itemTapAction: (String) -> Void

    var body: some View {
        ScrollView(.horizontal,
                   showsIndicators: false) {
            LazyHStack(alignment: .center, spacing: 8) {
                ForEach(genres, id: \.self) { genre in
                    // TODO: make this not default to false.
                    GenreItem(genre: genre,
                              isSelected: selectedGenres.contains(genre))
                        .onTapGesture {
                            itemTapAction(genre)
                        }
                }
            }
        }.fixedSize(horizontal: false,
                    vertical: true)
    }
}

struct GenreList_Previews: PreviewProvider {
    static var previews: some View {
        GenreList(genres: ["Action", "Adventure", "Animation", "Drama"],
                  selectedGenres: []) { genre in
            print("genre")
        }
            .preferredColorScheme(.dark)
    }
}
