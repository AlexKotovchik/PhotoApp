//
//  LoginViewModel.swift
//  PhotoApp
//
//  Created by AlexKotov on 17.03.22.
//

import Foundation
import SwiftUI
import Combine


class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = "" {
        didSet {
            if password.count > 12  {
                password = oldValue
            }
        }
    }
    @Published var loginButtonIsActive: Bool = false
    @Published var shouldShowRegisterView: Bool = false
    
    @Published var authenticationError: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $shouldShowRegisterView
            .receive(on: RunLoop.main)
            .filter { $0 == false }
            .sink { [weak self] _ in
                self?.username = ""
                self?.password = ""
            }
            .store(in: &cancellables)
        
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
            .assign(to: &$loginButtonIsActive)
    }
    
    func login(username: String, password: String, completion: () -> Void) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?

        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
//               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let pass = String(data: passwordData, encoding: .utf8),
               password == pass
            {
                completion()
            }
            else {
                authenticationError = "wrong_login_error".localized
            }
        } else {
            authenticationError = "wrong_login_error".localized
        }
    }
}


