//
//  DateCardSwiftUIView.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/12/21.
//

import SwiftUI

struct DateCardView: View {
    var body: some View {
        CardContentView()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(25)
    }
}

struct CardContentView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            posterImage
            MovieDetailView()
        }
    }
    
    var posterImage: some View {
        RemoteImageView(imageData: .failure(nil), defaultImage: UIImage(systemName: "film")!, height: 136)
//        Image("endgame")
//            .resizable()
//            .scaledToFill()
//            .frame(height: 136)
//            .clipped()
    }
}


struct MovieDetailView: View {
    var body: some View {
        HStack {
            Text("Avengers: Endgame")
            Spacer()
            Image("disney plus")
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
        }
        .padding()
    }
    
}


































struct DateCardSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DateCardView()
            .preferredColorScheme(.dark)
    }
}
