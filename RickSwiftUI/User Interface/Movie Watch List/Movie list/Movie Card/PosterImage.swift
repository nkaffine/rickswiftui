//
//  PosterImage.swift
//  PosterImage
//
//  Created by Nicholas Kaffine on 8/27/21.
//

import SwiftUI

struct PosterImage: View {
    let posterURL: URL?
    @ObservedObject
    private var imageLoader: ImageLoader

    init(posterURL: URL?) {
        self.posterURL = posterURL
        self.imageLoader = ImageLoader(link: posterURL?.absoluteString ?? "")
    }

    var body: some View {
        switch imageLoader.image {
            case .failure:
                posterPlaceholder
            case .loading:
                ProgressView()
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
        }
    }

    private var posterPlaceholder: some View {
        Image(uiImage: UIImage(systemName: "film")!)
    }
}

struct PosterImage_Previews: PreviewProvider {
    static var previews: some View {
        PosterImage(posterURL: MockMovies.endgame.posterUrl)
    }
}
