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
    @Published var shouldShowImagePicker: Bool = false
    @Published var shouldShowDialog: Bool = false
//    @Published var shouldShowCarouselView: Bool = false
    @Published var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
//    @Published var selectedPhoto: Photo?
//    @Published var selectedIndex: Int = 0
    
    var photoColumnGrid = [GridItem(.flexible(), spacing: 2),
                           GridItem(.flexible(), spacing: 2),
                           GridItem(.flexible(), spacing: 2)]
    
    private let storage = Storage.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getPhotos()
        
//        $selectedPhoto
//            .receive(on: RunLoop.main)
//            .sink { photo in
//                guard let photo = photo else { return }
//                self.selectedIndex = self.photos.firstIndex(of: photo) ?? 0
//            }
//            .store(in: &cancellables)
    }
    
    func getPhotos() {
        guard let photos = storage.photos,
        let decoded = try? JSONDecoder().decode([StoredPhoto].self, from: photos)
        else { return }
        self.photos = decoded.map { Photo(image: UIImage(data: $0.image) ?? UIImage(), description: $0.description)}
    }
    
    func savePhotos() {
        let storedPhotos = photos.map { StoredPhoto(id: $0.id, image: $0.image.pngData() ?? Data(), description: $0.description)}
        guard let encoded = try? JSONEncoder().encode(storedPhotos) else { return }
        storage.photos = encoded
    }
    
    func logOut() {
        storage.isAuthenticated = false
    }
    
    func addImage(_ image: UIImage) {
        let photo = Photo(image: image, description: "")
        photos.append(photo)
    }
}
