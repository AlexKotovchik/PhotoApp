//
//  AcceptButton.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import Foundation
import SwiftUI

struct AcceptButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
        }
        .padding()
        .background(isActive ? Color.blue : Color.gray)
        .cornerRadius(5)
        .disabled(!isActive)
    }
}
