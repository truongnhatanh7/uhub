//
//  SignupScreenView.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 02/09/2022.
//

import SwiftUI

struct SignupScreenView: View {
    @EnvironmentObject var pageVm: PageViewModel
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    @State private var email = ""
    @State private var pwd = ""
    @State private var rememberedMe = false
    @State private var isButtonDisabled = true
    
    @State private var isSigningUp = false
    
    /// This function will render the sign up view
    var body: some View {
        ZStack {
            if isSigningUp {
                ProgressView("Signing up ...")
                    .progressViewStyle(.circular)
                    .tint(Color("pink_primary"))
                    .foregroundColor(Color("pink_primary"))
                    .task {
                        userAuthManager.signUp(inputEmail: email, inputPwd: pwd, callback: {
                            self.isSigningUp.toggle()
                            if userAuthManager.errorMsg == "" {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    pageVm.isfirstFlow = true
                                    pageVm.visit(page: .EditProfile)
                                }
                            } else {
                                print(userAuthManager.errorMsg)
                            }
                        })
                    }
            } else {
                VStack(alignment: .center) {
                    // hearts image
                    Spacer()
                    Image("flying_hearts")
                        .resizable()
                        .frame(width: 250, height: 250)
                    
                    // sign up title
                    Text("Create an Account")
                        .bold()
                        .foregroundColor(Color("black_primary"))
                        .font(.title)
                        .padding(.vertical, 20)
                    
                    // 2 text input fields
                    VStack(spacing: 35) {
                        VStack {
                            TextInputComponent(
                                label: "Email",
                                value: $email,
                                placeholder: "Email",
                                isRequired: true
                            ).onChange(of: email) { _ in
                                if !email.isEmpty && !pwd.isEmpty {
                                    if isButtonDisabled {
                                        isButtonDisabled.toggle()
                                    }
                                } else {
                                    if !isButtonDisabled {
                                        isButtonDisabled.toggle()
                                    }
                                }
                            }
                            
                            if userAuthManager.errorMsg != ""
                                && !userAuthManager.errorMsg.lowercased().contains("password") {
                                if userAuthManager.errorMsg.lowercased().contains("already") {
                                    ErrorMsgView(msg: "Email already exists")
                                } else {
                                    ErrorMsgView(msg: "Valid email format: abc123@mail.provider.com")
                                }
                            }
                        }
                        
                        VStack {
                            TextInputComponent(
                                label: "Password",
                                value: $pwd,
                                placeholder: "Password",
                                isSecure: true,
                                isRequired: true
                            ).onChange(of: pwd) { _ in
                                if !email.isEmpty && !pwd.isEmpty {
                                    if isButtonDisabled {
                                        isButtonDisabled.toggle()
                                    }
                                } else {
                                    if !isButtonDisabled {
                                        isButtonDisabled.toggle()
                                    }
                                }
                            }
                            
                            if userAuthManager.errorMsg != ""
                                && userAuthManager.errorMsg.lowercased().contains("password") {
                                ErrorMsgView(msg: "Valid password format: at least 6 characters")
                            }
                        }
                    }
                    
                    // sign up button
                    ButtonBindingView(textContent: "Sign Up", onTap: {
                        self.isSigningUp.toggle()
                    }, isDisabled: $isButtonDisabled)
                    .padding(.top, 45)
                    
                    // already have an account + navigate to Sign In button
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            pageVm.visit(page: .SignIn)
                            userAuthManager.errorMsg = ""
                        }) {
                            Text("Sign In")
                                .bold()
                        }
                        .foregroundColor(Color("pink_primary"))
                    }
                    .padding(.vertical, 20)
                }
                .padding(20)
            }
        }
        .ignoresSafeArea()
    }
}
