//
//  GalleryView.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import Foundation
import SwiftUI

struct GalleryView: View {
    @StateObject var vm = GalleryViewModel()
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: vm.photoColumnGrid, alignment: .leading, spacing: 2) {
                            ForEach(vm.photos) { photo in
                                NavigationLink(destination:  PhotoCarouselView(photos: vm.photos, selectedID: photo.id)) {
                                    Image(uiImage: photo.image)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fill)
                                        .clipped()
//                                        .onTapGesture {
//                                            vm.selectedPhoto = photo
//                                        }
                                }
 
                            }
                        }
                    }
                }
                
                Button {
                    vm.shouldShowDialog = true
                } label: {
                    Text("add_image_btn".localized)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                
//                if let selectedPhoto = vm.selectedPhoto {
//                    NavigationLink(destination: PhotoCarouselView(photos: vm.photos, selectedPhoto: selectedPhoto), isActive: $vm.shouldShowCarouselView) {
//                        EmptyView()
//                    }
//                }
            }
            .onDisappear {
                vm.savePhotos()
            }
            .fullScreenCover(isPresented: $vm.shouldShowImagePicker) {
                ImagePicker(sourceType: vm.pickerSourceType) { image in
                    vm.addImage(image)
                }
            }
            .confirmationDialog("photo_cd_title".localized, isPresented: $vm.shouldShowDialog, actions: {
                Button("photo_cd_gallery_btn".localized, role: .none) {
                    vm.pickerSourceType = .photoLibrary
                    vm.shouldShowImagePicker = true
                }
                Button("photo_cd_camera_btn".localized, role: .none) {
                    vm.pickerSourceType = .camera
                    vm.shouldShowImagePicker = true
                }
            })
            .navigationBarTitle("gallery_view_title".localized)
            .navigationBarItems(trailing: logoutButton)
            
        }
        .accentColor(Color.backButtonForeground)
        
    }
    
    init() {
//        self.vm = GalleryViewModel()
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
