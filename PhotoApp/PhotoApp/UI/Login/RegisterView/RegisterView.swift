//
//  RegisterView.swift
//  PhotoApp
//
//  Created by AlexKotov on 17.03.22.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @ObservedObject var vm: RegisterViewModel
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    LoginFields(username: $vm.username, password: $vm.password)
                        .padding(.top, 32)
                        .padding(.bottom, 48)
                    
                    AcceptButton(title: "register_btn".localized,
                                 isActive: vm.registerButtonIsActive) {
                        vm.checkPasswordValidate()
                    }
                    
                    Text(vm.authenticationError)
                        .foregroundColor(.errorForeground)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding(.horizontal)
                .background(Color.viewBackground)
                .edgesIgnoringSafeArea(.all)
                
                Spacer()
                    .alert(isPresented: $vm.shouldShowRegistrationAlert, content: {
                        Alert(title: Text("register_alert_title".localized),
                              message: Text("register_alert_message".localized),
                              dismissButton:
                                .default(Text("ok_btn".localized)
                                    .foregroundColor(.blue), action: {
                                        vm.finishRegistration()                                    }))
                    })
            }
        }
        .navigationTitle("register_view_title")
    }
    
    init(shouldShowRegisterView: Binding<Bool>) {
        self.vm = RegisterViewModel(shouldShowRegisterView: shouldShowRegisterView)
    }
}
