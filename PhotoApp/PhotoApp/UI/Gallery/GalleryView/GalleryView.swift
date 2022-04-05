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
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { proxy in
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                LazyVGrid(columns: vm.photoColumnGrid, alignment: .leading, spacing: 2) {
                                    ForEach(vm.photos) { photo in
                                        NavigationLink(destination:  PhotoCarouselView(photos: vm.photos, selectedID: photo.id)) {
                                            Image(uiImage: photo.image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: (proxy.size.width - 4) / 3, height: (proxy.size.width - 4) / 3)
                                                .clipped()
                                                .contextMenu {
                                                    Button(action: {
                                                        vm.removePhoto(photo)
                                                    }) {
                                                        Text("delete_btn")
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
                            Text("add_image_btn".localized)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.textFieldAccent)
                        .foregroundColor(.addImageForeground)
                        
                    }
                }
                
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
                .navigationBarTitle("gallery_view_title".localized)
                .navigationBarItems(trailing: logoutButton)
                
            }
            .accentColor(Color.backButtonForeground)
            
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
            Image(systemName: "arrow.left.circle.fill")
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(Color.backButtonForeground)
        }
    }
    
}
