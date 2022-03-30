//
//  RegisterViewModel.swift
//  PhotoApp
//
//  Created by AlexKotov on 17.03.22.
//

import Foundation
import SwiftUI
import Combine
import Security

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Binding var isAuthenticated: Bool
    
    @Published var registerButtonIsActive: Bool = false
    @Published var shouldShowRegistrationAlert: Bool = false
    
    @Published var authenticationError: String = ""
    
    @Binding var shouldShowRegisterView: Bool
    
    private var cancellables = Set<AnyCancellable>()
    private let storage = Storage.shared
    
    init(shouldShowRegisterView: Binding<Bool>, isAuthenticated: Binding<Bool>) {
        _shouldShowRegisterView = shouldShowRegisterView
        _isAuthenticated = isAuthenticated
        
        $username
            .receive(on: RunLoop.main)
            .map { _ in "" }
            .assign(to: &$authenticationError)
        
        $password
            .receive(on: RunLoop.main)
            .map { _ in "" }
            .assign(to: &$authenticationError)
        
        Publishers.CombineLatest($username, $password)
            .receive(on: RunLoop.main)
            .map { !$0.0.isEmpty && !$0.1.isEmpty}
            .assign(to: &$registerButtonIsActive)
    }
    
    func checkPasswordValidate() {
        if password.count >= 8 {
            register(username: username, password: password)
        } else {
            authenticationError = "password_length_error".localized
        }
    }
    
    func register(username: String, password: String) {
        guard let password = password.data(using: .utf8) else { return }
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: password,
        ]

        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            debugPrint("User saved successfully in the keychain")
            shouldShowRegistrationAlert = true
            storage.user = username
        } else {
            authenticationError = "user_exists_error".localized
        }
    }
    
    func finishRegistration() {
        storage.isAuthenticated = true
        isAuthenticated = true
//        shouldShowRegisterView = false
    }
}
