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
    var image: Data
    var description: String
    
    init(image: UIImage, description: String = "description") {
        self.id = UUID().uuidString
        self.image = image.pngData() ?? Data()
        self.description = description
    }
}
