//
//  CounterCardView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/19/21.
//

import SwiftUI

struct CounterCardView: View {
    let id: Int
    let title: String
    let date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: .some(Constants.cardVerticalSpacing)) {
            Text(title).fontWeight(.bold)
            Counter(date: date)
        }
        .frame(width: 240)
        .padding(Constants.cardOuterPadding)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(Constants.cardCornerRadius)
    }

    private struct Constants {
        static let cardOuterPadding: CGFloat = 32
        static let cardVerticalSpacing: CGFloat = 16
        static let cardCornerRadius: CGFloat = 16
    }
}

struct CounterCardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CounterViewModel()
        let first = viewModel.dates.first!
        CounterCardView(id: first.id, title: first.title, date: first.date)
    }
}
