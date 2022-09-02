//
//  TextInputView.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 02/09/2022.
//

import SwiftUI

struct TextInput: View {
    @State var label: String?
    @Binding var value : String
    @State var placeholder : String?
    @State var isSecure: Bool?
    @State var isRequired: Bool?
    
    @FocusState private var isFocused: Bool
    @State private var isTextHidden: Bool = true
    @State private var focusTracker: Bool = false
    
    var body: some View {
        HStack{
            if isSecure ?? false{
                if isTextHidden {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("\(label!)")
                            .padding(.horizontal, 20)
                            .overlay(alignment: .topTrailing, content: {
                                if isRequired ?? false {
                                    Text("*")
                                        .foregroundColor(.red)
                                        .padding(.trailing, 12)
                                }
                            })
                        SecureField("\(placeholder!)", text: self.$value)
                            .focused($isFocused)
                            .onChange(of: isFocused) { newValue in
                                focusTracker = newValue
                            }
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal,20)
                            .padding(.trailing,28)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(
                                        focusTracker ? Color("pink_primary") : Color.gray.opacity(0.4),
                                        lineWidth: 2
                                    )
                                    .frame(height: 50)
                            )
                        
                    }
                    .overlay(
                        Button(
                            action: {
                                self.isTextHidden.toggle()
                            }
                        ) {
                            SideIcon(iconName: "eye.fill", iconColor: .gray)
                        }
                            .padding(.trailing, 20)
                            .padding(.top, 48)
                        , alignment: .topTrailing
                    )
                } else {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("\(label!)")
                            .padding(.horizontal, 20)
                            .overlay(alignment: .topTrailing, content: {
                                if isRequired ?? false {
                                    Text("*")
                                        .foregroundColor(.red)
                                        .padding(.trailing, 12)
                                }
                            })
                        TextField("\(placeholder!)", text: self.$value)
                            .focused($isFocused)
                            .onChange(of: isFocused) { newValue in
                                focusTracker = newValue
                            }
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal,20)
                            .padding(.trailing,28)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(
                                        focusTracker ? Color("pink_primary") : Color.gray.opacity(0.4),
                                        lineWidth: 2
                                    )
                                    .frame(height: 50)
                            )
                    }
                    .overlay(
                        Button(
                            action: {
                                self.isTextHidden.toggle()
                            }
                        ) {
                            SideIcon(iconName: "eye.slash.fill", iconColor: .gray)
                        }
                            .padding(.trailing, 20)
                        , alignment: .bottomTrailing
                    )
                }
            } else {
                VStack(alignment: .leading, spacing: 25) {
                    Text("\(label!)")
                        .padding(.horizontal, 20)
                        .overlay(alignment: .topTrailing, content: {
                            if isRequired ?? false {
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.trailing, 12)
                            }
                        })
                    TextField("\(placeholder!)", text: self.$value)
                        .focused($isFocused)
                        .onChange(of: isFocused) { newValue in
                            focusTracker = newValue
                        }
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal,20)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(
                                    focusTracker ? Color("pink_primary") : Color.gray.opacity(0.4),
                                    lineWidth: 2
                                )
                                .frame(height: 50)
                        )
                }
            }
        }
    }
}

struct SideIcon: View {
    private var iconName: String
    private var iconColor: Color
    
    init(iconName: String, iconColor: Color) {
        self.iconName = iconName
        self.iconColor = iconColor
    }
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(iconColor)
    }
}

struct TextInput_Previews: PreviewProvider {
    struct TestSecureFieldSwitch: View {
        @State private var text = ""
        @State private var pass = ""
        var body: some View {
            VStack(spacing: 50){
                TextInput(
                    label: "Email",
                    value: $text,
                    placeholder: "Email",
                    isRequired: true
                )
                
                TextInput(
                    label: "Password",
                    value: $pass,
                    placeholder: "Password",
                    isSecure: true,
                    isRequired: true
                )
            }
        }
    }
    
    static var previews: some View {
        TestSecureFieldSwitch()
    }
}

