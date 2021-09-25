//
//  MovieWatchListServerErrorView.swift
//  MovieWatchListServerErrorView
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import SwiftUI

struct MovieWatchListServerErrorView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 3)
                Text("Something went wrong please try again")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width / 2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct MovieWatchListServerErrorView_Previews: PreviewProvider {
    static var previews: some View {
        MovieWatchListServerErrorView()
            .preferredColorScheme(.dark)
    }
}
