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
                VStack {
                    Image(uiImage: UIImage(data: photo.image) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: proxy.size.width, height: proxy.size.width)
                        .clipped()
                    TextEditor(text: $vm.selectedPhoto.description) .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding()
                    Spacer()
                }
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
