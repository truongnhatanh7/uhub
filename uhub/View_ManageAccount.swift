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

struct ManageAccountView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    @State var showLogoutModal = false
    @State var showDeleteModal = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                StandardHeader(title: "Manage Account") {
                    pageVM.visit(page: pageVM.previousPage ?? .Account)
                }
                
                ListRow(icon: "person.fill.badge.minus", label: "Delete Account", showNavigationIcon: false) {
                    withAnimation { showDeleteModal = true }
                }
                ListRow(icon: "ipad.and.arrow.forward", label: "Logout", showNavigationIcon: false) {
                    withAnimation { showLogoutModal = true }
                }
                
                Spacer()
            }
            OneThirdModal(label: "Confirmation", showModal: $showDeleteModal) {
                VStack {
                    Text("Are you sure you want to delete account?")
                        .padding(.vertical)
                    
                    Text("Once you delete, all the data will be removed!")
                        .font(.callout)
                    
                    HStack(spacing: 20) {
                        ButtonView(textContent: "No", isSecondaryBtn: true) {
                            withAnimation { showDeleteModal = false }
                        }
                        ButtonView(textContent: "Yes") {
                            withAnimation {
                                userAuthManager.deleteAccount()
                                pageVM.visit(page: .SignUp)
                                pageVM.previousPage = nil
                            }
                        }
                    }
                    .padding()
                }
            }
            
            OneThirdModal(label: "Confirmation", showModal: $showLogoutModal) {
                VStack {
                    Text("Are you sure you want to logout?")
                        .padding()
                    HStack(spacing: 20) {
                        ButtonView(textContent: "No", isSecondaryBtn: true) {
                            withAnimation { showLogoutModal = false }
                        }
                        ButtonView(textContent: "Yes") {
                            withAnimation {
                                userAuthManager.signOut()
                                pageVM.visit(page: .SignUp)
                                pageVM.previousPage = nil
                            }
                        }
                    }
                    .padding()
                }
            }
            
        }
    }
}
