//
//  GalleryView.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import Foundation
import SwiftUI

struct GalleryView: View {
    @ObservedObject var vm: GalleryViewModel
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: vm.photoColumnGrid, alignment: .leading, spacing: 2) {
                            ForEach(vm.photos) { photo in
                                if let imageData = photo.image,
                                   let uiimage = UIImage(data: imageData) {
                                    NavigationLink(destination: PhotoCarouselView()) {
                                        Image(uiImage: uiimage)
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fill)
                                            .clipped()
                                            .onTapGesture {
//                                                vm.shouldShowCarouselView = true
                                            }
                                    }
                                   
                                }
                            }
                        }
                    }
                }
                
                Button {
                    vm.shouldShowDialog = true
                } label: {
                    Text("Add image")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                
            }
            .fullScreenCover(isPresented: $vm.shouldShowImagePicker) {
                ImagePicker(sourceType: vm.pickerSourceType) { image in
                    vm.addImage(image)
                }
            }
            .confirmationDialog("Choose photo from", isPresented: $vm.shouldShowDialog, actions: {
                Button("Gallery", role: .none) {
                    vm.pickerSourceType = .photoLibrary
                    vm.shouldShowImagePicker = true
                }
                Button("Camera", role: .none) {
                    vm.pickerSourceType = .camera
                    vm.shouldShowImagePicker = true
                }
            })
            .navigationBarTitle("My photos")
            .navigationBarItems(trailing: logoutButton)
            
//            NavigationLink(destination: PhotoCarouselView(), isActive: $vm.shouldShowCarouselView) {
//                EmptyView()
//            }
            
        }
    }
    
    init() {
        self.vm = GalleryViewModel()
    }
}

extension GalleryView {
    var logoutButton: some View {
        Menu {
            Button(action: {
                viewModel.isAuthenticated = false
                vm.logOut()
            }) {
                Text("Logout")
            }
        } label: {
            Image(systemName: "arrow.left.circle.fill")
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(Color.backButtonForeground)
        }
    }
    
    
}
