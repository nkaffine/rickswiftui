//
//  DateVIEW.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/19/21.
//

import SwiftUI

struct DateView: View {
    @ObservedObject
    var viewModel: DateViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack {
                dateCategories
                    .padding(.top, 16)
                Spacer()
                AddButtonView()
                    .frame(width: geometry.size.width * 0.25)
                    .position(CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).maxY))
            }
        }
    }

    @ViewBuilder
    private var dateCategories: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(viewModel.categories, id: \.title) { (category) in
                    DateCategoryView(categoryEmoji: category.emoji, categoryTitle: category.title, isActive: false)
                }
            }
        }
        .padding(.leading, 16)
    }
}

struct DateVIEW_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DateViewModel()
        DateView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
