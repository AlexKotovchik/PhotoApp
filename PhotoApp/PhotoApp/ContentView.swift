//
//  ContentView.swift
//  PhotoApp
//
//  Created by AlexKotov on 17.03.22.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = Storage.shared.isAuthenticated
}

struct ContentView: View {
    @StateObject var vm: ContentViewModel
    
    var body: some View {
        if vm.isAuthenticated {
            GalleryView()
                .environmentObject(vm)
        } else {
            LoginView()
                .environmentObject(vm)
        }
    }
    
    init() {
        let vm = StateObject(wrappedValue: ContentViewModel())
        _vm = vm
    }
}

