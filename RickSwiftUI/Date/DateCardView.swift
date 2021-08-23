//
//  DateCardSwiftUIView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/12/21.
//

import SwiftUI

struct DateCardView<InfoContent: View>: View {
    let headerImageLink: String
    let infoContent: InfoContent
    let placeholderImage: Image

    init(headerImageLink: String, placeholderImage: Image, @ViewBuilder infoContent: () -> InfoContent) {
        self.headerImageLink = headerImageLink
        self.infoContent = infoContent()
        self.placeholderImage = placeholderImage
    }

    var body: some View {
        VStack(spacing: 0) {
            headerImage
            infoContent
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(25)
    }

    var headerImage: some View {
        let imageLoader = ImageLoader(link: headerImageLink)
        return RemoteImageView(imageLoader: imageLoader) {
                ProgressView()
            } errorView: {
                // TODO: need to make this not just related to films.
                placeholderImage
            } successView: { image in
                image
            }
            .frame(height: 136)
    }
}


































struct DateCardSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {

        DateCardView(headerImageLink: "https://s3.amazonaws.com/prod.assets.thebanner/styles/article-large/s3/article/large/MM-037%20Avengers_%20Endgame.jpg?itok=VvMw-Ym7",
                     placeholderImage: Image(uiImage: UIImage(systemName: "film")!),
                     infoContent: {
            HStack {
                Text("Avengers: Endgame")
                Spacer()
                Image("disney")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32, alignment: .center)
                    .clipShape(Circle())
            }
            .padding()
        })
        .preferredColorScheme(.dark)
    }
}
