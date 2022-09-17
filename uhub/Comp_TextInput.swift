/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Authors:
 + S3877980 - Ho Le Minh Thach
 + S3878231 - Truong Nhat Anh
 + S3877698 - Nguyen Luu Quoc Bao
 + S3820098  - Le Nguyen Truong An
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgements: Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import SwiftUI

struct TextInputComponent: View {
    @State var label: String?
    @Binding var value: String
    @State var placeholder: String
    @State var isSecure: Bool
    @State var isRequired: Bool
    let icon: String?
    
    @FocusState private var isFocused: Bool
    @State private var isTextHidden: Bool = true
    
    init(label: String? = nil, value: Binding<String>, placeholder: String = "", isSecure: Bool = false, isRequired: Bool = false, icon: String? = nil) {
        _label = State(initialValue: label)
        _value = value
        _placeholder = State(initialValue: placeholder)
        _isSecure = State(initialValue: isSecure)
        _isRequired = State(initialValue: isRequired)
        _isTextHidden = State(initialValue: isSecure)
        self.icon = icon
    }
    
    /// View body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let label = label {
                Text(label).modifier(LabelStyle(isRequired: isRequired))
            }
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(isFocused ? Color("pink_primary") : Color("black_primary"), lineWidth: 2)
                    .frame(height: 50)
                HStack {
                    /// is text hidden -> render secure field
                    if isTextHidden {
                        SecureField(placeholder, text: $value)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .modifier(InputStyle(isFocused: $isFocused))
                    } else { /// render text field
                        TextField(placeholder, text: $value)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .modifier(InputStyle(isFocused: $isFocused))
                    }
                    /// is secure -> render button
                    if isSecure {
                        Button(action: { self.isTextHidden.toggle() }, label: { Image(systemName: isTextHidden ? "eye.fill" : "eye.slash.fill").foregroundColor(.gray) })
                            .padding(.trailing, 20)
                    } else {
                        if let icon = icon {
                            Image(systemName: icon)
                                .foregroundColor(isFocused ? Color("pink_primary") : Color.gray.opacity(0.4))
                                .padding(.trailing, 20)
                        }
                    }
                }
            }
        }
    }
}
