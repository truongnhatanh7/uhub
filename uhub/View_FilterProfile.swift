//
//  FilterProfileView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 06/09/2022.
//

import SwiftUI

struct FilterProfileView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @StateObject var filterProfileVM = FilterProfileViewModel()
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    /// This will render the filter profile
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 30) {
                        PickerInputComponent(label: "Age", value: $filterProfileVM.filterAge, showPicker: $filterProfileVM.showAgePicker)
                        
                        PickerInputComponent(label: "GPA", value: $filterProfileVM.filterGPA, showPicker: $filterProfileVM.showGPAPicker)
                        
                        PickerInputComponent(label: "Semester Learned", value: $filterProfileVM.filterSemester, showPicker: $filterProfileVM.showSemesterLearned)
                    }
                    .padding()
                    .padding(.top, 60)
                }
                StandardHeader(title: "Filter People") {
                    if pageVM.isfirstFlow {
                        pageVM.visit(page: .EditProfile)
                    } else {
                        pageVM.visit(page: pageVM.previousPage ?? .FilterProfile)
                    }
                }
            }
            BottomBar {
                ButtonView(textContent: pageVM.isfirstFlow ? "Next" : "Submit") {
                    filterProfileVM.submitData(userAuthManager, callback: switchPageForBtn)
                }
            }
            
            PickerInputModal(label: "Filter age", showPicker: $filterProfileVM.showAgePicker, value: $filterProfileVM.filterAge)
            
            PickerInputModal(label: "Filter GPA", showPicker: $filterProfileVM.showGPAPicker, value: $filterProfileVM.filterGPA)
            
            PickerInputModal(label: "Filter semester learned", showPicker: $filterProfileVM.showSemesterLearned, value: $filterProfileVM.filterSemester)
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            filterProfileVM.updateInfo(userAuthManager.currentUserData)
        }
    }
    
    /// This function will switch the page after click the button
    private func switchPageForBtn() {
        if userAuthManager.errorMsg == "" {
            if pageVM.isfirstFlow {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    pageVM.visit(page: .Congrat)
                }
            } else {
                pageVM.visit(page: pageVM.previousPage ?? .FilterProfile)
            }
        } else {
            print(userAuthManager.errorMsg)
        }
    }
}
