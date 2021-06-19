//
//  RemoteImageView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/12/21.
//

import SwiftUI

enum RemoteImageData {
    case loading
    case success(Data)
    case failure(Error?)
}

struct RemoteImageView: View {
    let imageData: RemoteImageData
    let defaultImage: UIImage
    let height: CGFloat
    
    var body: some View {
        switch imageData {
            case .loading:
                loadingView
            case .success(let data):
                if let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: height)
                        .clipped()
                } else {
                    defaultView
                }
            case .failure:
                defaultView
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .frame(height: height)
    }
    
    private var defaultView: some View {
        Image(uiImage: defaultImage)
            .resizable()
            .padding(height)
            .aspectRatio(contentMode: .fit)
    }
}

struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(imageData: .failure(nil), defaultImage: UIImage(systemName: "film")!, height: 136)
    }
}
