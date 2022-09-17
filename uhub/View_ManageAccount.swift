//
//  ManageAccount.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 10/09/2022.
//

import SwiftUI

struct ManageAccountView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    @State var showLogoutModal = false
    @State var showDeleteModal = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
//                VStack {
                    StandardHeader(title: "Manage Account") {
                        pageVM.visit(page: pageVM.previousPage ?? .Account)
                    }
//                }
                
//                VStack {
                    ListRow(icon: "person.fill.badge.minus", label: "Delete Account", showNavigationIcon: false) {
                        withAnimation { showDeleteModal = true }
                    }
                    ListRow(icon: "ipad.and.arrow.forward", label: "Logout", showNavigationIcon: false) {
                        withAnimation { showLogoutModal = true }
                    }
                
                Spacer()
                    
//                }.background(Color("background")).padding()
//                .listStyle(.plain)
              
            }.padding()
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
