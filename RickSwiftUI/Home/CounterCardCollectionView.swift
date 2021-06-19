//
//  CounterCardCollectionView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/19/21.
//

import SwiftUI

struct CounterCardCollectionView: View {
    @ObservedObject var viewModel: CounterViewModel

    var body: some View {
        LazyHStack(alignment: .top) {
            ForEach(viewModel.dates) { dateInfo in
                CounterCardView(id: dateInfo.id, title: dateInfo.title, date: dateInfo.date)
            }
        }
        .modifier(ScrollingHStackModifier(items: viewModel.dates.count,
                                          itemWidth: Constants.itemWidth,
                                          itemSpacing: Constants.itemSpacing))
        .fixedSize(horizontal: false, vertical: true)
    }

    private struct Constants {
        static let itemWidth: CGFloat = 240 + 64
        static let itemSpacing: CGFloat = 0
    }
}

































struct CounterCardCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CounterViewModel()
        CounterCardCollectionView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
