//
//  RemoteImageView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/12/21.
//

import SwiftUI

struct RemoteImageView<LoadingContent: View, ErrorContent: View, SuccessContent: View>: View {
    @ObservedObject
    var imageLoader: ImageLoader

    let loadingView: LoadingContent
    let errorView: ErrorContent
    let successView: (Image) -> SuccessContent

    init(imageLoader: ImageLoader,
         @ViewBuilder loadingView: () -> LoadingContent,
         @ViewBuilder errorView: () -> ErrorContent,
         @ViewBuilder successView: @escaping (Image) -> SuccessContent)
    {
        self.imageLoader = imageLoader
        self.loadingView = loadingView()
        self.errorView = errorView()
        self.successView = successView
    }
    
    var body: some View {
        GeometryReader { geometry in
            switch imageLoader.image {
                case .loading:
                    loadingView
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                case .success(let image):
                    successView(Image(uiImage: image))
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                        .clipped()
                case .failure:
                    errorView
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
            }
        }
    }
}

struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        let imageLoader = ImageLoader(link: "https://s3.amazonaws.com/prod.assets.thebanner/styles/article-large/s3/article/large/MM-037%20Avengers_%20Endgame.jpg?itok=VvMw-Ym7")
        RemoteImageView(imageLoader: imageLoader,
                        loadingView: { ProgressView() },
                        errorView: { Image(systemName: "film")},
                        successView: {image in return image})
    }
}
