//
//  LoginFields.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import Foundation
import SwiftUI

struct LoginFields: View {
    @Binding var username: String
    @Binding var password: String
    
    var body: some View {
        VStack {
            Group {
                TextField("username_ph".localized, text: $username)
                    .textFieldModifier()
                PasswordField(password: $password)
                
            }
            .padding(12)
            .font(.system(size: 16))
            .background(Color.textFieldBackground)
            .cornerRadius(5)
        }
    }
}
