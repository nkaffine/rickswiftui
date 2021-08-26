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

    let loadingView: (GeometryProxy) -> LoadingContent
    let errorView: (GeometryProxy) -> ErrorContent
    let successView: (Image, GeometryProxy) -> SuccessContent

    init(imageLoader: ImageLoader,
         @ViewBuilder loadingView: @escaping (GeometryProxy) -> LoadingContent,
         @ViewBuilder errorView: @escaping (GeometryProxy) -> ErrorContent,
         @ViewBuilder successView: @escaping (Image, GeometryProxy) -> SuccessContent)
    {
        self.imageLoader = imageLoader
        self.loadingView = loadingView
        self.errorView = errorView
        self.successView = successView
    }
    
    var body: some View {
        GeometryReader { geometry in
            switch imageLoader.image {
                case .loading:
                    loadingView(geometry)
                case .success(let image):
                    successView(Image(uiImage: image), geometry)
                case .failure:
                    errorView(geometry)
            }
        }
    }
}

struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        let imageLoader = ImageLoader(link: "https://s3.amazonaws.com/prod.assets.thebanner/styles/article-large/s3/article/large/MM-037%20Avengers_%20Endgame.jpg?itok=VvMw-Ym7")
        RemoteImageView(imageLoader: imageLoader,
                        loadingView: { _ in
                            ProgressView()
                        },
                        errorView: { _ in
                            Image(systemName: "film")

                        },
                        successView: {image, geometry in
                            image.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        })
    }
}
