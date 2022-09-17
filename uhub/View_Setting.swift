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

struct SettingView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @State var showMenu = false
    
    /// Render the navigation view for setting
    var body: some View {
        VStack {
            HeaderHome(title: "Setting")
            VStack {
                ListRow(icon: "square.and.pencil", label: "Edit Profile") {
                    pageVM.visit(page: .EditProfile)
                }
                ListRow(icon: "person.fill", label: "Manage Account") {
                    pageVM.visit(page: .Account)
                }
                ListRow(icon: "bell.fill", label: "Notification") {
                    pageVM.visit(page: .Notification)
                }
                ListRow(icon: "slider.horizontal.3", label: "Filter People") {
                    pageVM.visit(page: .FilterProfile)
                }
            }.padding()
            
            Spacer()
            if showMenu {
                BottomBar {
                    MenuBar(menuInPage: .Setting, showMenu: $showMenu)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            withAnimation { showMenu = true }
        }
    }
}
