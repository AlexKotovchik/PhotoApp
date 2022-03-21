//
//  GalleryViewModel.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import Foundation
import SwiftUI
import Combine

class GalleryViewModel: ObservableObject {
    @Published var photos: [Photo] = []
//    [Photo(image:UIImage(named: "1")!),
//                                      Photo(image:UIImage(named: "2")!),
//                                      Photo(image:UIImage(named: "3")!),
//                                      Photo(image:UIImage(named: "4")!),
//                                      Photo(image:UIImage(named: "5")!)]
    @Published var shouldShowImagePicker: Bool = false
    @Published var shouldShowDialog: Bool = false
    @Published var shouldShowCarouselView: Bool = false
    @Published var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var photoColumnGrid = [GridItem(.flexible(), spacing: 2),
                           GridItem(.flexible(), spacing: 2),
                           GridItem(.flexible(), spacing: 2)]
    
    private let storage = Storage.shared
    
    init() {
        getPhotos()
    }
    
    func getPhotos() {
        guard let photos = storage.photos,
        let decoded = try? JSONDecoder().decode([Photo].self, from: photos)
        else { return }
        self.photos = decoded
    }
    
    func savePhotos() {
        guard let encoded = try? JSONEncoder().encode(photos) else { return }
        storage.photos = encoded
    }
    
    func logOut() {
        storage.isAuthenticated = false
    }
    
    func addImage(_ image: UIImage) {
        let photo = Photo(image: image)
        photos.append(photo)
        savePhotos()
    }
}
