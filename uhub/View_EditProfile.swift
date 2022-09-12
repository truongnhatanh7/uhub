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
                StandardHeader(title: "Fill Your Profile", showReturn: !pageVM.isfirstFlow, action: { pageVM.visit(page: pageVM.previousPage ?? pageVM.currentPage ) })
            }
            BottomBar {
                ButtonView(textContent: "Next", isDisabled: editProfileVM.isDisabled, onTap: submitData)
            }
            
            PickerInputModal(label: "Your age", showPicker: $editProfileVM.showAgePicker, value: $editProfileVM.age, items: editProfileVM.ageRange)
            PickerInputModal(label: "Your GPA", showPicker: $editProfileVM.showGPAPicker, value: $editProfileVM.gpa, items: editProfileVM.GPARange)
            PickerInputModal(label: "Semester learned", showPicker: $editProfileVM.showSemesterLearned, value: $editProfileVM.semesterLearned, items: editProfileVM.semesterLearnedRange)
            
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
            if userAuthManager.currentUserData["id"] != nil {
                editProfileVM.updateInfo(userAuthManager.currentUserData)
                
                if !pageVM.isfirstFlow {
                    editProfileVM.retrieveImage(
                        userId: userAuthManager.currentUserData["id"] as! String,
                        callback: {
                            editProfileVM.loadImage()
                        }
                    )
                }
            }
        }
    }
    
    private func submitData() {
        // upload chosen profile image to Storage
        if userAuthManager.currentUserData["id"] != nil {
            editProfileVM.uploadImage(userId: userAuthManager.currentUserData["id"] as! String) {
                
                // when finish uploading image, update users info on Firestore
                userAuthManager.updateProfileInfo(updatedData: [
                    "fullname": editProfileVM.fullname,
                    "age": editProfileVM.age,
                    "school": editProfileVM.school,
                    "major": editProfileVM.major,
                    "gpa": editProfileVM.gpa,
                    "semester_learned": editProfileVM.semesterLearned,
                    "about": editProfileVM.about
                ], callback: {
                    if userAuthManager.errorMsg == "" {
                        pageVM.visit(page: .FilterProfile)
                    } else {
                        print(userAuthManager.errorMsg)
                    }
                })
            }
        } else {
            print("[FAILURE - Upload User Image at Edit Profile View]: user is not identified")
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
            
            PickerInputComponent(label: "Age", value: $editProfileVM.age, isRequired: true, items: editProfileVM.ageRange, showPicker: $editProfileVM.showAgePicker)
            
            TextInputComponent(label: "School", value: $editProfileVM.school, placeholder: "School Name", isRequired: true, icon: "mappin.and.ellipse")
                .focused($isFocusKeyboard, equals: .School)
            
            TextInputComponent(label: "Major", value: $editProfileVM.major, placeholder: "Learning Major", isRequired: true, icon: "graduationcap")
                .focused($isFocusKeyboard, equals: .Major)
            
            PickerInputComponent(label: "GPA", value: $editProfileVM.gpa, isRequired: true, items: editProfileVM.GPARange, showPicker: $editProfileVM.showGPAPicker)
            
            PickerInputComponent(label: "Semester Learned", value: $editProfileVM.semesterLearned, isRequired: true, items: editProfileVM.semesterLearnedRange, showPicker: $editProfileVM.showSemesterLearned)
            
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
