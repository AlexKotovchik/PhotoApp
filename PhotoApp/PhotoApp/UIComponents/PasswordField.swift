//
//  PasswordField.swift
//  PhotoApp
//
//  Created by AlexKotov on 17.03.22.
//

import Foundation
import SwiftUI

struct PasswordField: View {
    @State var shouldShowPassword: Bool = false
    @Binding var password: String
    
    var body: some View {
        HStack {
            ZStack {
                Group {
                    SecureField("password_ph".localized , text: $password)
                        .opacity(shouldShowPassword ? 0 : 1)
                    TextField("password_ph".localized , text: $password)
                        .opacity(shouldShowPassword ? 1 : 0)
                    
                }
//                .onReceive(password.publisher.collect()) {
//                        self.password = String($0.prefix(5))
//                    }
                .textFieldModifier()
                
                HStack {
                    Spacer()
                    Button {
                        shouldShowPassword.toggle()
                    } label: {
                        Image(systemName: shouldShowPassword ? "eye" : "eye.slash")
                            .foregroundColor(shouldShowPassword ? .black : .gray)
                    }
                }
            }
        }
    }
}
