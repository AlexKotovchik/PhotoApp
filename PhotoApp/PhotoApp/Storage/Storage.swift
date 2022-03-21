//
//  Storage.swift
//  PhotoApp
//
//  Created by AlexKotov on 19.03.22.
//

import Foundation

struct StorageKeys {
    static let photos = "photos"
    static let authentication = "authentication"
}

class Storage: ObservableObject {
    static let shared: Storage = .init()
    
    init() {
    }
    
    var photos: Data? {
        set {
            UserDefaults.standard.set(newValue, forKey: StorageKeys.photos)
        }
        get {
            return UserDefaults.standard.data(forKey: StorageKeys.photos)
        }
    }
    
    var isAuthenticated: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: StorageKeys.authentication)
        }
        get {
            UserDefaults.standard.bool(forKey: StorageKeys.authentication)
        }
    }
}
