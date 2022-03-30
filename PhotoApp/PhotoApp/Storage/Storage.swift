//
//  Storage.swift
//  PhotoApp
//
//  Created by AlexKotov on 19.03.22.
//

import Foundation

struct StorageKeys {
    static let authentication = "authentication"
    static let user = "user"
}

class Storage: ObservableObject {
    static let shared: Storage = .init()
    
    init() {
    }
    
    var isAuthenticated: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: StorageKeys.authentication)
        }
        get {
            UserDefaults.standard.bool(forKey: StorageKeys.authentication)
        }
    }
    
    var user: String {
        set {
            UserDefaults.standard.set(newValue, forKey: StorageKeys.user)
        }
        get {
            UserDefaults.standard.string(forKey: StorageKeys.user) ?? ""
        }
    }
}
