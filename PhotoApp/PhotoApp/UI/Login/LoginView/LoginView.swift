//
//  LoginView.swift
//  PhotoApp
//
//  Created by AlexKotov on 17.03.22.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @ObservedObject var vm: LoginViewModel
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView {
                    VStack {
                        Image(uiImage: UIImage(named: "PhotoApp") ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 32)
                            .padding(.bottom)
                        
                        LoginFields(username: $vm.username, password: $vm.password)
                            .padding(.vertical, 48)

                        AcceptButton(title: "login_btn".localized,
                                     isActive: vm.loginButtonIsActive) {
                            vm.login(username: vm.username, password: vm.password) {
                                viewModel.isAuthenticated = true
                                Storage.shared.isAuthenticated = true
                                Storage.shared.user = vm.username
                            }
                        }
                        
                        Text(vm.authenticationError)
                            .foregroundColor(.errorForeground)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                            .frame(minHeight: 16)
                            .padding()
                        
                        HStack {
                            Spacer()
                            Text("account_lbl".localized)
                                .foregroundColor(Color.textFieldForeground)
                            NavigationLink(destination: RegisterView(shouldShowRegisterView: $vm.shouldShowRegisterView, isAuthenticated: $viewModel.isAuthenticated), isActive: $vm.shouldShowRegisterView) {
                                Text("register_lbl".localized)
                                    .foregroundColor(.linkColorForeground)
                            }
                            Spacer()
                        }
                        .font(.system(size: 15))
                    }
                    .frame(minHeight: proxy.size.height)
                }
                .padding(.horizontal)
                .background(Color.viewBackground)
                .edgesIgnoringSafeArea(.all)
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
        }
        .accentColor(Color.backButtonForeground)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    
    init() {
        self.vm = LoginViewModel()
    }
}
