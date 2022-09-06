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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 30) {
                        PickerInputComponent(label: "Age", value: $filterProfileVM.filterAge, items: filterProfileVM.ageRange, showPicker: $filterProfileVM.showAgePicker)
                        
                        PickerInputComponent(label: "GPA", value: $filterProfileVM.filterGPA, items: filterProfileVM.GPARange, showPicker: $filterProfileVM.showGPAPicker)
                        
                        PickerInputComponent(label: "Semester Learned", value: $filterProfileVM.filterSemester, items: filterProfileVM.semesterLearnedRange, showPicker: $filterProfileVM.showSemesterLearned)
                    }
                    .padding()
                    .padding(.top, 60)
                }
                StandardHeader(title: "Filter People") {
                    pageVM.visit(page: .EditProfile)
                }
            }
            BottomBar {
                ButtonView(textContent: "Next", onTap: {
                    userAuthManager.updateProfileInfo(updatedData: [
                        "friends_filter": [
                            "friends_age": filterProfileVM.filterAge,
                            "freinds_gpa": filterProfileVM.filterGPA,
                            "friends_semester_learned": filterProfileVM.filterSemester
                        ]
                    ], callback: {
                        pageVM.visit(page: .Notification)
                    })
                }, isDisabled: false)
            }
            
            PickerInputModal(label: "Filter age", showPicker: $filterProfileVM.showAgePicker, value: $filterProfileVM.filterAge, items: filterProfileVM.ageRange)
            
            PickerInputModal(label: "Filter GPA", showPicker: $filterProfileVM.showGPAPicker, value: $filterProfileVM.filterGPA, items: filterProfileVM.GPARange)
            
            PickerInputModal(label: "Filter semester learned", showPicker: $filterProfileVM.showSemesterLearned, value: $filterProfileVM.filterSemester, items: filterProfileVM.semesterLearnedRange)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
