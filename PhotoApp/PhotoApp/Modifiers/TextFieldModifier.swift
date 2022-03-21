//
//  TextFieldModifier.swift
//  PhotoApp
//
//  Created by AlexKotov on 17.03.22.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .accentColor(.textFieldAccent)
            .foregroundColor(.textFieldForeground)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}

extension View {
    func textFieldModifier() -> some View {
        modifier(TextFieldModifier())
    }
}
