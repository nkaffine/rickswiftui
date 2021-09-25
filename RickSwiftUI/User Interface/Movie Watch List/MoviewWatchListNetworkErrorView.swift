//
//  MoviewWatchListNetworkErrorView.swift
//  MoviewWatchListNetworkErrorView
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import SwiftUI

struct MoviewWatchListNetworkErrorView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 3)
                Text("Please check your internet connection and try again")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width / 2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct MoviewWatchListNetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewWatchListNetworkErrorView()
            .preferredColorScheme(.dark)
    }
}
