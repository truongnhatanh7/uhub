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
    @EnvironmentObject var userAuthManager: UserAuthManager
    
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
                        .padding(.bottom, 100)
                }
                StandardHeader(title: "Fill Your Profile", showReturn: !pageVM.isfirstFlow, action: { pageVM.visit(page: pageVM.previousPage ?? pageVM.currentPage) })
            }
            BottomBar {
                ButtonView(textContent: pageVM.isfirstFlow ? "Next" : "Submit", isDisabled: editProfileVM.isDisabled) {
                    editProfileVM.submitData(userAuthManager, callback: switchPageForBtn)
                }
            }
            
            PickerInputModalInt(label: "Your age", showPicker: $editProfileVM.showAgePicker, value: $editProfileVM.age, items: editProfileVM.ageRange)
            PickerInputModal(label: "Your GPA", showPicker: $editProfileVM.showGPAPicker, value: $editProfileVM.gpa)
            PickerInputModalInt(label: "Semester learned", showPicker: $editProfileVM.showSemesterLearned, value: $editProfileVM.semesterLearned, items: editProfileVM.semesterLearnedRange)
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .environmentObject(editProfileVM)
        .sheet(isPresented: $editProfileVM.showImagePicker) {
            ImagePicker(image: $editProfileVM.inputImage)
        }
        .onChange(of: editProfileVM.inputImage) { _ in
            editProfileVM.loadImage()
        }
        .onAppear {
            editProfileVM.updateInfo(userAuthManager.currentUserData)
        }
    }
    
    private func switchPageForBtn() {
        if userAuthManager.errorMsg == "" {
            if pageVM.isfirstFlow {
                pageVM.visit(page: .FilterProfile)
            } else {
                pageVM.visit(page: pageVM.previousPage ?? pageVM.currentPage)
            }
        } else {
            print(userAuthManager.errorMsg)
        }
    }
}

struct TextInputSubView: View {
    @EnvironmentObject var userAuthManager: UserAuthManager
    @EnvironmentObject var pageVM: PageViewModel
    @EnvironmentObject var editProfileVM: EditProfileViewModel
    @FocusState private var isFocusKeyboard: Field?
    
    var body: some View {
        VStack(spacing: 30) {
            TextInputComponent(label: "Full Name", value: $editProfileVM.fullname, placeholder: "Full Name", isSecure: false, isRequired: true, icon: "person")
                .focused($isFocusKeyboard, equals: .FullName)
            
            PickerInputComponentForInt(label: "Age", value: $editProfileVM.age, isRequired: true, showPicker: $editProfileVM.showAgePicker)
            
            TextInputComponent(label: "School", value: $editProfileVM.school, placeholder: "School Name", isRequired: true, icon: "mappin.and.ellipse")
                .focused($isFocusKeyboard, equals: .School)
            
            TextInputComponent(label: "Major", value: $editProfileVM.major, placeholder: "Learning Major", isRequired: true, icon: "graduationcap")
                .focused($isFocusKeyboard, equals: .Major)
            
            PickerInputComponent(label: "GPA", value: $editProfileVM.gpa, isRequired: true, showPicker: $editProfileVM.showGPAPicker)
            
            PickerInputComponentForInt(label: "Semester Learned", value: $editProfileVM.semesterLearned, isRequired: true, showPicker: $editProfileVM.showSemesterLearned)
            
            TextBox(label: "About", value: $editProfileVM.about, placeholder: "Tell me about yourself")
                .focused($isFocusKeyboard, equals: .About)
        }
        .padding()
        .onTapGesture {
            if isFocusKeyboard != nil {
                isFocusKeyboard = nil
            }
        }
    }
}
