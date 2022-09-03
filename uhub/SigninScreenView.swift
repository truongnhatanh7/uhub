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
    
    @State private var email = ""
    @State private var pwd = ""
    @State private var rememberedMe = false
    
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
                        TextInputComponent(
                            label: "Email",
                            value: $email,
                            placeholder: "Email",
                            isRequired: true
                        )
                        
                        TextInputComponent(
                            label: "Password",
                            value: $pwd,
                            placeholder: "Password",
                            isSecure: true,
                            isRequired: true
                        )
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
                    ButtonView(textContent: "Sign In", onTap: {
                        userAuthManager.signIn(inputEmail: email, inputPwd: pwd, callback: {
                            if userAuthManager.isLoggedin {
                                pageVM.visit(page: .Home)
                                print("\(userAuthManager.response)")
                            }
                        })
                    })
                    
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
