//
//  LocalFileManager.swift
//  PhotoApp
//
//  Created by AlexKotov on 25.03.22.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let shared = LocalFileManager()
    
    func savePhoto(_ photo: Photo) {
        guard let imageData = photo.image.jpegData(compressionQuality: 0.2) else { return }
        let storedPhoto = StoredPhoto(id: photo.id,
                                      image: imageData,
                                      date: photo.date,
                                      description: photo.description)
        guard let data = try? JSONEncoder().encode(storedPhoto) else { return }
        
        let folderPath = folderPath()
        let destinationURL: URL = folderPath.appendingPathComponent("\(storedPhoto.id)")
        
        if !FileManager.default.fileExists(atPath: destinationURL.relativePath) {
            do {
                try data.write(to: destinationURL)
            } catch let error {
                print("Writing data failed \(error)")
            }
        } else {
            print("The file already exists")
        }
    }
    
    func getPhotos() -> [Photo] {
        var photos = [Photo]()
        let folderPath = folderPath()
        guard FileManager.default.fileExists(atPath: folderPath.relativePath) else {
            print("Folder dont exist")
            return []
        }
        do {
            let photoPaths = try FileManager.default.contentsOfDirectory(atPath: folderPath.path)
            for path in photoPaths {
                let photoUrl = folderPath.appendingPathComponent(path)
                print(photoUrl)
                guard
                      let storedPhoto = try? Data(contentsOf: photoUrl),
                      let decoded = try? JSONDecoder().decode(StoredPhoto.self, from: storedPhoto) else { return [] }
                let photo = Photo(id: decoded.id, image: UIImage(data: decoded.image) ?? UIImage(), description: decoded.description)
                photos.append(photo)
            }
        } catch let error {
            print(error)
        }
        return photos
    }
    
    func deletePhoto(_ photo: Photo) {
        let folderPath = folderPath()
        let destinationURL: URL = folderPath.appendingPathComponent("\(photo.id)")
        print(destinationURL)
        if FileManager.default.fileExists(atPath: destinationURL.relativePath) {
            do {
                try FileManager.default.removeItem(at: destinationURL)
            } catch let error {
                print("Deleting photo failed \(error)")
            }
        } else {
            print("No such photo")
        }
    }
    
    func folderPath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let photosFolderURL = documentsDirectory.appendingPathComponent("Photos")
        let userPhotosFolderUrl = photosFolderURL.appendingPathComponent(Storage.shared.user)
        if !FileManager.default.fileExists(atPath: photosFolderURL.relativePath) {
            do {
                try FileManager.default.createDirectory(
                    at: photosFolderURL,
                    withIntermediateDirectories: false,
                    attributes: nil
                )
            } catch let error {
                print("Creating photos folder failed. \(error)")
            }
        }
        
        if !FileManager.default.fileExists(atPath: userPhotosFolderUrl.relativePath) {
            do {
                try FileManager.default.createDirectory(
                    at: userPhotosFolderUrl,
                    withIntermediateDirectories: false,
                    attributes: nil
                )
            } catch let error {
                print("Creating user photos folder failed. \(error)")
            }
        }
        return userPhotosFolderUrl
    }
}
