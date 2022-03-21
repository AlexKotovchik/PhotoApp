//
//  PhotoCarouselView.swift
//  PhotoApp
//
//  Created by AlexKotov on 21.03.22.
//

import Foundation
import SwiftUI

struct PhotoCarouselView: View {
    @ObservedObject var vm: PhotoCarouselViewModel
    
    var body: some View {
        Text("Test")
    }
    
    init() {
        self.vm = PhotoCarouselViewModel()
    }
}
