//
//  HeaderImage.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/12/21.
//

import SwiftUI

struct HeaderImage: View {
    let image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(height: 136)
                .clipped()
        } else {
            ProgressView()
                .frame(height: 136)
        }
    }
}

struct HeaderImage_Previews: PreviewProvider {
    static var previews: some View {
        HeaderImage(image: nil).preferredColorScheme(.dark)
        HeaderImage(image: UIImage(named: "endgame")).preferredColorScheme(.dark)
    }
}
