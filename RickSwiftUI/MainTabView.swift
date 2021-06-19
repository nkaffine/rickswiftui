//
//  MainTabView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/15/21.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            home
                .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            dates
                .tabItem {
                    Image(systemName: "heart")
                    Text("Dates")
                }
        }
    }
    
    private var home: some View {
        let viewModel = CounterViewModel()
        return VStack {
            CounterCardCollectionView(viewModel: viewModel)
            Spacer()
        }
    }
    
    private var dates: some View {
        Text("Dates")
    }
}


























struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .preferredColorScheme(.dark)
    }
}
