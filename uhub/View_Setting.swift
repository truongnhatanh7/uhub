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
                ListRow(icon: "square.and.pencil", label: "Edit Profile") {
                    pageVM.visit(page: .EditProfile)
                }
                ListRow(icon: "person.fill", label: "Manage Account") {
                    pageVM.visit(page: .Account)
                }
                ListRow(icon: "bell.fill", label: "Notification") {
                    pageVM.visit(page: .Notification)
//                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                ListRow(icon: "slider.horizontal.3", label: "Filter People") {
                    pageVM.visit(page: .FilterProfile)
                }
            }.background(Color("background")).listStyle(.plain)
            
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
