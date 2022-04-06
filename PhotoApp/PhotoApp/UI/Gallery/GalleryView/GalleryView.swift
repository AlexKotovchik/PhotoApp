//
//  GalleryView.swift
//  PhotoApp
//
//  Created by AlexKotov on 18.03.22.
//

import Foundation
import SwiftUI

struct GalleryView: View {
    @ObservedObject var vm = GalleryViewModel()
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                photoGrid
                navigationLink
                imagePickerView
                cameraAccessAlert
            }
            .navigationBarTitle("gallery_view_title".localized)
            .navigationBarItems(leading: addImageButton, trailing: logoutButton)
        }
        .accentColor(Color.backButtonForeground)
        .animation(.none)
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
                Text("logout_btn")
            }
        } label: {
            Image(systemName: "arrow.left")
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(.backButtonForeground)
        }
    }
    
    var cameraAccessAlert: some View {
        Spacer()
            .alert(isPresented: $vm.shouldShowCameraAccessAlert, content: {
                Alert(title: Text("camera_access_alert_title".localized),
                      message: Text("camera_access_alert_message".localized),
                      primaryButton: .default(Text("settings_btn".localized), action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                              options: [:], completionHandler: nil)
                }),
                      secondaryButton: .cancel() )
            })
    }
    
    var addImageButton: some View {
        Button {
            vm.shouldShowDialog = true
        } label: {
            Image(systemName: "plus")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.backButtonForeground)
    }
    
    var imagePickerView: some View {
        Spacer()
            .fullScreenCover(isPresented: $vm.shouldShowImagePicker) {
                ImagePicker(sourceType: vm.pickerSourceType) { image in
                    vm.addImage(image)
                }
            }
            .confirmationDialog("photo_cd_title".localized, isPresented: $vm.shouldShowDialog, actions: {
                Button("photo_cd_gallery_btn".localized, role: .none) {
                    vm.openGallery()
                }
                Button("photo_cd_camera_btn".localized, role: .none) {
                    vm.checkCameraAccess()
                }
            })
    }
    
    var navigationLink: some View {
        NavigationLink(isActive: $vm.shouldShowCarousel) {
            PhotoCarouselView(photos: vm.photos, selectedID: vm.selectedID ?? "")
        } label: {
            EmptyView()
        }
    }
    
    var photoGrid: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: vm.photoColumnGrid, alignment: .leading, spacing: 2) {
                    ForEach(vm.photos) { photo in
                        imageView(photo: photo, proxy: proxy)
                    }
                }
            }
        }
    }
    
    func imageView(photo: Photo, proxy: GeometryProxy) -> some View {
        return AnyView(
            Image(uiImage: photo.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (proxy.size.width - 4) / 3, height: (proxy.size.width - 4) / 3)
                .clipped()
                .onTapGesture(perform: {
                    vm.selectedID = photo.id
                    vm.shouldShowCarousel = true
                })
        )
    }
    
}
