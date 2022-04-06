//
//  PhotoCarouselViewModel.swift
//  PhotoApp
//
//  Created by AlexKotov on 21.03.22.
//

import Foundation
import SwiftUI

class PhotoCarouselViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var selectedID: String
    
    init(photos: [Photo], selectedID: String) {
        self.photos = photos
        self.selectedID = selectedID
    }
    
}
