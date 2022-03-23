//
//  Photo.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import Foundation
import UIKit

struct StoredPhoto: Identifiable, Codable {
    var id: String
    var image: Data
    var description: String
    
    init(id: String, image: Data, description: String) {
        self.id = id
        self.image = image
        self.description = description
    }
}
