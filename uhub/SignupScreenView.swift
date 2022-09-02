//
//  SignupScreenView.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 02/09/2022.
//

import SwiftUI

import SwiftUI

struct SignupScreenView: View {
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
                    Text("Create an Account")
                        .bold()
                        .foregroundColor(Color("black_primary"))
                        .font(.title)
                        .padding(.vertical, 30)
                    
                    // 2 text input fields
                    VStack(spacing: 45) {
                        TextInput(
                            label: "Email",
                            value: $email,
                            placeholder: "Email",
                            isRequired: true
                        )
                        
                        TextInput(
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
                    
                    // sign up button
                    ButtonView(textContent: "Sign Up", onTap: {})
                    
                    // already have an account + navigate to Sign In button
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        
                        Button(action: {}) {
                            Text("Sign In")
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

struct SignupScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreenView()
            .previewInterfaceOrientation(.portrait)
    }
}

