//
//  ContentView.swift
//  PhotoApp
//
//  Created by AlexKotov on 17.03.22.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = Storage.shared.isAuthenticated
}

struct MainView: View {
    @ObservedObject var vm: MainViewModel
    
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
//        let vm = StateObject(wrappedValue: MainViewModel())
//        _vm = vm
        self.vm = MainViewModel()
    }
}

