//
//  ImageLoader.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/19/21.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    enum ImageData {
        case loading
        case success(UIImage)
        case failure
    }

    @Published
    private (set) var image: ImageData

    private var link: String

    init(link: String) {
        self.link = link
        self.image = .loading
        loadImageFromLink()
    }

    func loadImageFromLink() {
        guard let url = URL(string: self.link) else {
            self.image = .failure
            return
        }

        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.image = .failure
                }
                return
            }
            DispatchQueue.main.async {
                self?.image = .success(image)
            }
        }
    }
}
