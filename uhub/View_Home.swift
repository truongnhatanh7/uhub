//
//  HomeView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct HomeView: View {
    @State var showMenu = false

    var body: some View {
        VStack {
            Spacer()
            if showMenu {
                BottomBar {
                    MenuBar(menuInPage: .Home, showMenu: $showMenu)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            withAnimation { showMenu = true }
        }
    }
}