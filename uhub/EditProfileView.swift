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
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                ScrollView {
                    AvatarInput(image: editProfileVM.image) {
                        editProfileVM.showImagePicker.toggle()
                    }
                    .padding(.top, 60)
                    
                    TextInputSubView()
                }
//                StandardHeader(title: "Fill Your Profile", showReturn: false, action: {})
            }
            PickerInputModal(label: "Your age", showPicker: $editProfileVM.showAgePicker, value: $editProfileVM.age, items: editProfileVM.ageRange)
            PickerInputModal(label: "Your GPA", showPicker: $editProfileVM.showGPAPicker, value: $editProfileVM.gpa, items: editProfileVM.GPARange)
            PickerInputModal(label: "Semester learned", showPicker: $editProfileVM.showSemesterLearned, value: $editProfileVM.semesterLearned, items: editProfileVM.semesterLearnedRange)

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
            
            PickerInputComponent(label: "Age", value: $editProfileVM.age, placeholder: "Select your age", isRequired: true, items: editProfileVM.ageRange, showPicker: $editProfileVM.showAgePicker)
            
            TextInputComponent(label: "Email", value: $editProfileVM.email, placeholder: "Email", isRequired: true, icon: "envelope")
                .focused($isFocusKeyboard, equals: .Email)
            
            TextInputComponent(label: "School", value: $editProfileVM.school, placeholder: "School Name", isRequired: true, icon: "mappin.and.ellipse")
                .focused($isFocusKeyboard, equals: .School)
            
            TextInputComponent(label: "Major", value: $editProfileVM.major, placeholder: "Learning Major", isRequired: true, icon: "graduationcap")
                .focused($isFocusKeyboard, equals: .Major)
            
            PickerInputComponent(label: "GPA", value: $editProfileVM.gpa, placeholder: "Select your GPA", isRequired: true, items: editProfileVM.GPARange, showPicker: $editProfileVM.showGPAPicker)
            
            PickerInputComponent(label: "Semester Learned", value: $editProfileVM.semesterLearned, placeholder: "Select number of learned semester", isRequired: true, items: editProfileVM.semesterLearnedRange, showPicker: $editProfileVM.showSemesterLearned)
            
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
