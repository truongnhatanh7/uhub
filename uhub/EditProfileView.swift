//
//  EditProfileView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 03/09/2022.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var pageVM: PageViewModel
    
    @State private var fullName = ""
    @ObservedObject private var age = NumbersOnly()
    @State private var email = ""
    @State private var school = ""
    @State private var major = ""
    @ObservedObject private var gpa = NumbersOnly()
    @ObservedObject private var semesterLearned = NumbersOnly()
    @State private var about = ""
    
    private enum Field: Int {
        case FullName, Age, Email, School, Major, GPA, SemeterLearned, About
    }
    @FocusState private var isFocusKeyboard: Field?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                TextInputComponent(label: "Full Name", value: $fullName, placeholder: "Full Name", isSecure: false, isRequired: true, icon: "person")
                    .focused($isFocusKeyboard, equals: .FullName)
                
                TextInputComponent(label: "Age", value: $age.value, placeholder: "Your age", isRequired: true, icon: "calendar")
                    .keyboardType(.numberPad)
                    .focused($isFocusKeyboard, equals: .Age)
                
                TextInputComponent(label: "Email", value: $email, placeholder: "Email", isRequired: true, icon: "envelope")
                    .focused($isFocusKeyboard, equals: .Email)
                
                TextInputComponent(label: "School", value: $school, placeholder: "School Name", isRequired: true, icon: "mappin.and.ellipse")
                    .focused($isFocusKeyboard, equals: .School)
                
                TextInputComponent(label: "Major", value: $major, placeholder: "Learning Major", isRequired: true, icon: "graduationcap")
                    .focused($isFocusKeyboard, equals: .Major)
                
                TextInputComponent(label: "GPA", value: $gpa.value, placeholder: "Your GPA", isRequired: true, icon: "number")
                    .keyboardType(.numberPad)
                    .focused($isFocusKeyboard, equals: .GPA)
                
                TextInputComponent(label: "Semester Learned", value: $semesterLearned.value, placeholder: "Number of semester", isRequired: true, icon: "clock")
                    .keyboardType(.numberPad)
                    .focused($isFocusKeyboard, equals: .SemeterLearned)
                
                TextBox(label: "About", value: $about, placeholder: "Tell me about yourself")
                    .focused($isFocusKeyboard, equals: .About)
                
                ButtonView(textContent: "Next", onTap: {
                    pageVM.visit(page: .FilterProfile)
                }, isDisabled: false)
            }
            .padding()
            .onTapGesture {
                if isFocusKeyboard != nil {
                    isFocusKeyboard = nil
                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
