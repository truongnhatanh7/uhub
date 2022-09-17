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
