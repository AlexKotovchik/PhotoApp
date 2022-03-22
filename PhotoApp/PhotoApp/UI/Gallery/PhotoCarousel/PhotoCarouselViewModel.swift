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
    @Published var selectedPhoto: Photo
    
    init(photos: [Photo], selectedPhoto: Photo) {
        self.photos = photos
        self.selectedPhoto = selectedPhoto
    }
}
