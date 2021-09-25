//
//  MovieWatchListLoadingView.swift
//  MovieWatchListLoadingView
//
//  Created by Nicholas Kaffine on 9/25/21.
//

import SwiftUI

struct MovieWatchListLoadingView: View {
    var body: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MovieWatchListLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        MovieWatchListLoadingView()
            .preferredColorScheme(.dark)
    }
}
