//
//  GalleryViewModel.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import AVFoundation
import Foundation
import SwiftUI
import Combine

class GalleryViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var shouldShowImagePicker: Bool = false
    @Published var shouldShowDialog: Bool = false
    @Published var shouldShowCameraAccessAlert: Bool = false
    @Published var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var photoColumnGrid = [GridItem(.flexible(), spacing: 2),
                           GridItem(.flexible(), spacing: 2),
                           GridItem(.flexible(), spacing: 2)]
    
    private let storage = Storage.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.photos = LocalFileManager.shared.getPhotos()
            .sorted { $0.date < $1.date}
    }
    
    func logOut() {
        storage.isAuthenticated = false
    }
    
    func addImage(_ image: UIImage) {
        let photo = Photo(image: image, date: Date(), description: "")
        LocalFileManager.shared.savePhoto(photo)
        photos.append(photo)
    }
    
    func openCamera() {
        pickerSourceType = .camera
        shouldShowImagePicker = true
    }
    
    func openGallery() {
        pickerSourceType = .photoLibrary
        shouldShowImagePicker = true
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            openCamera()
        case .denied, .restricted:
            shouldShowCameraAccessAlert = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    self.openCamera()
                } else {
                    debugPrint("Permission denied")
                }
            }
        @unknown default:
            print("unknown")
        }
    }
}
