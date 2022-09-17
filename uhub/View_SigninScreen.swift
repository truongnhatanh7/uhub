//
//  LoginScreenView.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 02/09/2022.
//

import SwiftUI

struct SigninScreenView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @EnvironmentObject var userAuthManager: UserAuthManager
    @EnvironmentObject var chatEngine: ChatEngine
    @EnvironmentObject var notiManager: NotiManager
    
    @State private var email = ""
    @State private var pwd = ""
    @State private var rememberedMe = false
    @State private var errorMsg = ""
    @State private var isButtonDisabled = true
    
    @State private var isSigningIn = false
    
    /// This function will render the sign in view
    var body: some View {
        ZStack {
            if isSigningIn {
                ProgressView("Signing in ...")
                    .progressViewStyle(.circular)
                    .tint(Color("pink_primary"))
                    .foregroundColor(Color("pink_primary"))
                    .task {
                        userAuthManager.signIn(inputEmail: email, inputPwd: pwd, callback: {
                            self.isSigningIn.toggle()
                            if userAuthManager.errorMsg == "" {
                                chatEngine.loadChatList {
                                    chatEngine.fetchUserStatus()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    pageVM.visit(page: .Home)
                                }
                            } else {
                                print(userAuthManager.errorMsg)
                            }
                        }, firstTime: false)
                    }
            } else {
                VStack {
                    // hearts image
                    Spacer()
                    Image("flying_hearts")
                        .resizable()
                        .frame(width: 250, height: 250)
                    
                    // sign up title
                    Text("Let's Sign You In")
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
                                ErrorMsgView(msg: "Invalid email")
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
                                ErrorMsgView(msg: "Invalid password")
                            }
                        }
                    }
                    
                    // sign in button
                    ButtonBindingView(textContent: "Sign In", onTap: {
                        self.isSigningIn.toggle()
                    }, isDisabled: $isButtonDisabled)
                    .padding(.top, 45)
                    
                    // dont have an account + navigate to Sign Up button
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            pageVM.visit(page: .SignUp)
                            userAuthManager.errorMsg = ""
                        }) {
                            Text("Sign Up")
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
