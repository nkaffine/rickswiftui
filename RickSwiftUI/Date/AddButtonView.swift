//
//  AddButtonView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/19/21.
//

import SwiftUI

struct AddButtonView: View {
    var body: some View {
        Circle()
            .foregroundColor(Color(UIColor.secondarySystemBackground))
            .overlay(Image(systemName: "plus").resizable().aspectRatio(contentMode: .fit).padding())
            .aspectRatio(contentMode: .fit)
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView()
            .preferredColorScheme(.dark)
    }
}
