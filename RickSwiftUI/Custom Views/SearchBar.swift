//
//  SearchBar.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/21/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())

//        TextField.init("Search", text: $text) { isEditing in
//            print(isEditing)
//        } onCommit: {
//            print("commit")
//        }
//        .textFieldStyle(RoundedBorderTextFieldStyle())
//        .background(Color(UIColor.secondarySystemBackground))

//        TextField("Search", text: $text)
//            .padding(.all)
//            .background(Color(UIColor.secondarySystemBackground))
//            .cornerRadius(8)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
            .preferredColorScheme(.dark)
    }
}
