//
//  String+Extensions.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }
    
}
