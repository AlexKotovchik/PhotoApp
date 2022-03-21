//
//  Photo.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import Foundation
import UIKit

struct Photo: Identifiable, Codable {
    var id: String
    var image: Data?
    
    init(image: UIImage) {
        self.id = UUID().uuidString
        self.image = image.pngData()
    }
}
