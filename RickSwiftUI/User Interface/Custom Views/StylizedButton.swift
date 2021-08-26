//
//  StylizedButton.swift
//  StylizedButton
//
//  Created by Nicholas Kaffine on 8/26/21.
//

import SwiftUI

enum ButtonStyle {
    case primary
    case secondary
    case destructive
}

struct StylizedButton: View {
    let title: String
    let style: ButtonStyle
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(style.font)
                .foregroundColor(.primary)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .background(Color(style.backgroundColor))
                .cornerRadius(24)
        }
    }
}

private extension ButtonStyle {
    var backgroundColor: UIColor {
        switch self {
            case .primary:
                return .primary
            case .secondary:
                return .systemGray2
            case .destructive:
                return .systemRed
        }
    }

    var font: Font {
        switch self {
            case .primary:
                return .headline.bold()
            case .secondary, .destructive:
                return .headline
        }
    }
}

struct StylizedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StylizedButton(title: "Add Movie",
                           style: .primary) {
                print("Primary tapped")
            }
            StylizedButton(title: "Delete",
                           style: .destructive) {
                print("Destructive tapped")
            }
            StylizedButton(title: "Cancel",
                           style: .secondary) {
                print("Secondary tapped")
            }
        }
        .padding()
        .preferredColorScheme(.dark)

    }
}
