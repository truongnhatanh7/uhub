//
//  SettingView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @State var showMenu = false

    var body: some View {
        VStack {
            HeaderHome(title: "Setting")
            List {
                ListRow(action: {
                    pageVM.visit(page: .EditProfile)
                }, icon: "square.and.pencil", label: "Edit Profile")
                ListRow(action: {
//                    pageVM.visit(page: )
                }, icon: "person.fill", label: "Manage Account")
                ListRow(action: {
                    pageVM.visit(page: .Notification)
                }, icon: "bell.fill", label: "Notification")
                ListRow(action: {
                    pageVM.visit(page: .FilterProfile)
                }, icon: "slider.horizontal.3", label: "Filter People")
            }
            .listStyle(.plain)
            
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
