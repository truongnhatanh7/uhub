//
//  EditProfileView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 03/09/2022.
//

import SwiftUI
import Combine

struct EditProfileView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @StateObject var editProfileVM = EditProfileViewModel()
        
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                AvatarInput(image: editProfileVM.image) {
                    editProfileVM.showImagePicker.toggle()
                }
                .padding(.top, 60)
                
                TextInputSubView()
            }
            StandardHeader(title: "Fill Your Profile", showReturn: false, action: {})
        }
        .environmentObject(editProfileVM)
        .sheet(isPresented: $editProfileVM.showImagePicker) {
            ImagePicker(image: $editProfileVM.inputImage)
        }
        .onChange(of: editProfileVM.inputImage) { _ in
            editProfileVM.loadImage()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

struct TextInputSubView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @EnvironmentObject var editProfileVM: EditProfileViewModel
    @FocusState private var isFocusKeyboard: Field?

    var body: some View {
        VStack(spacing: 30) {
            TextInputComponent(label: "Full Name", value: $editProfileVM.fullname, placeholder: "Full Name", isSecure: false, isRequired: true, icon: "person")
                .focused($isFocusKeyboard, equals: .FullName)
            TextInputComponent(label: "Age", value: $editProfileVM.age, placeholder: "Your age", isRequired: true, icon: "calendar")
                .keyboardType(.numberPad)
                .focused($isFocusKeyboard, equals: .Age)
                .onReceive(Just(editProfileVM.age)) {
                    editProfileVM.updateField(.Age, $0)
                }
            TextInputComponent(label: "Email", value: $editProfileVM.email, placeholder: "Email", isRequired: true, icon: "envelope")
                .focused($isFocusKeyboard, equals: .Email)
            TextInputComponent(label: "School", value: $editProfileVM.school, placeholder: "School Name", isRequired: true, icon: "mappin.and.ellipse")
                .focused($isFocusKeyboard, equals: .School)
            TextInputComponent(label: "Major", value: $editProfileVM.major, placeholder: "Learning Major", isRequired: true, icon: "graduationcap")
                .focused($isFocusKeyboard, equals: .Major)
            TextInputComponent(label: "GPA", value: $editProfileVM.gpa, placeholder: "Your GPA", isRequired: true, icon: "number")
                .keyboardType(.numberPad)
                .focused($isFocusKeyboard, equals: .GPA)
                .onReceive(Just(editProfileVM.gpa)) {
                    editProfileVM.updateField(.GPA, $0)
                }
            TextInputComponent(label: "Semester Learned", value: $editProfileVM.semesterLearned, placeholder: "Number of semester", isRequired: true, icon: "clock")
                .keyboardType(.numberPad)
                .focused($isFocusKeyboard, equals: .SemeterLearned)
                .onReceive(Just(editProfileVM.semesterLearned)) {
                    editProfileVM.updateField(.SemeterLearned, $0)
                }
            TextBox(label: "About", value: $editProfileVM.about, placeholder: "Tell me about yourself")
                .focused($isFocusKeyboard, equals: .About)
            
            ButtonView(textContent: "Next", onTap: {
                pageVM.visit(page: .FilterProfile)
            }, isDisabled: editProfileVM.isDisabled)
        }
        .padding()
        .onTapGesture {
            if isFocusKeyboard != nil {
                isFocusKeyboard = nil
            }
        }
    }
}
