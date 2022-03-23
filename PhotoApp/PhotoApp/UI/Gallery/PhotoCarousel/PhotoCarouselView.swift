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
        GeometryReader { proxy in
        TabView {
            ForEach(vm.photos) { photo in
                PhotoView(photo: photo, proxy: proxy)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    }
    
    init(photos: [Photo], selectedPhoto: Photo) {
        self.vm = PhotoCarouselViewModel(photos: photos, selectedPhoto: selectedPhoto)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct PhotoView: View {
    @StateObject var photo: Photo
    let proxy: GeometryProxy
    
    var body: some View {
        VStack {
            Image(uiImage: photo.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: proxy.size.width, height: proxy.size.height / 2)
                .clipped()
            ZStack(alignment: .leading) {
                if photo.description.isEmpty {
                    VStack {
                        HStack {
                            Spacer()
                            Text("Tap to add comment")
                                .font(.system(size: 24))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                TextEditor(text: $photo.description)
                    .multilineTextAlignment(.center)
                    .opacity(photo.description.isEmpty ? 0.25 : 1)
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .accentColor(.black)
            }
            Spacer()
        }
    }
}
