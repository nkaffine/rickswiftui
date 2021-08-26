//
//  AddMovieButton.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 8/25/21.
//

import SwiftUI

struct AddMovieButton: View {
    var body: some View {
        Image(systemName: "plus")
            .font(.largeTitle)
            .frame(width: 75, height: 75, alignment: .center)
            .background(Color(UIColor.secondarySystemFill))
            .cornerRadius(50)
    }
}

struct AddMovieButton_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieButton()
            .preferredColorScheme(.dark)
    }
}
