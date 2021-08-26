//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Nicholas Kaffine on 8/26/21.
//

import SwiftUI

struct RoundedButtonModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .cornerRadius(geometry.size.height / 2)
                .background(Color.gray)
        }
    }
}

extension Button {
    func rounded() -> some View {
        self.modifier(RoundedButtonModifier())
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Button("This is a button") {
            print("This button was tapped")
        }
    }
}
