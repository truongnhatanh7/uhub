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
    
    var body: some View {
        ZStack {
            ScrollView {
                Spacer()
                
                VStack {
                    // hearts image
                    Spacer()
                    Image("flying_hearts")
                        .resizable()
                        .frame(width: 250, height: 200)
                        .padding(.top, 20)
                    
                    // sign up title
                    Spacer()
                    Text("Let's Sign You In")
                        .bold()
                        .foregroundColor(Color("black_primary"))
                        .font(.title)
                        .padding(.vertical, 30)
                    
                    // 2 text input fields
                    VStack(spacing: 45) {
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
                    
                    // remember me check box
                    HStack {
                        CheckBoxView(checked: $rememberedMe)
                        Text("Remember me")
                            .bold()
                            .font(.caption)
                            .foregroundColor(Color("black_primary"))
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .padding(.leading, 20)
                    
                    // sign in button
                    ButtonBindingView(textContent: "Sign In", onTap: {
                        // THIS LINE IS TEST ONLY
                        //self.notiManager.generateNoti(title: "UHUB", subtitle: "Mãi mãi là anh em cột chèo!")
                        userAuthManager.signIn(inputEmail: email, inputPwd: pwd, callback: {
                            if userAuthManager.errorMsg == "" {
                                chatEngine.loadChatList {
                                    chatEngine.fetchUserStatus()
                                }
                                pageVM.visit(page: .Home)
                            } else {
                                print(userAuthManager.errorMsg)
                            }
                        }, firstTime: false)
                    }, isDisabled: $isButtonDisabled)
                    
                    // forgot your password button
                    Button(action: {}) {
                        Text("Forgot your password?")
                            .bold()
                    }
                    .foregroundColor(Color("pink_primary"))
                    .padding(.top, 15)
                    
                    // dont have an account + navigate to Sign Up button
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            pageVM.visit(page: .SignUp)
                        }) {
                            Text("Sign Up")
                                .bold()
                        }
                        .foregroundColor(Color("pink_primary"))
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 300)
                }
                .padding(20)
            }
        }
        .ignoresSafeArea()
    }
}

struct SigninScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SigninScreenView()
    }
}
