//
//  Photo.swift
//  PhotoApp
//
//  Created by AlexKotov on 23.03.22.
//

import Foundation
import UIKit
import Combine

class Photo: ObservableObject, Identifiable, Equatable {
    var id: String
    var image: UIImage
    var date: Date
    @Published var description: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init(id: String = UUID().uuidString, image: UIImage, date: Date, description: String) {
        self.id = id
        self.image = image
        self.date = date
        self.description = description
        
        $description
            .receive(on: RunLoop.main)
            .dropFirst()
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { _ in
                self.resave()
            }
            .store(in: &cancellables)
        
    }
    
    func resave() {
        LocalFileManager.shared.deletePhoto(self)
        LocalFileManager.shared.savePhoto(self)
    }
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}
