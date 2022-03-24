//
//  Photo.swift
//  PhotoApp
//
//  Created by AlexKotov on 23.03.22.
//

import Foundation
import UIKit

class Photo: ObservableObject, Identifiable, Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    var image: UIImage
    @Published var description: String
    
    init(image: UIImage, description: String) {
        self.id = UUID().uuidString
        self.image = image
        self.description = description
    }
}
