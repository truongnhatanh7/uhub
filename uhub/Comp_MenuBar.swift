//
//  MenuBar.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

/// Menubar
struct MenuBar: View {
    @EnvironmentObject var pageVM: PageViewModel
    @EnvironmentObject var chatEngine: ChatEngine
    let menuInPage: Page
    @Binding var showMenu: Bool /// Control menu show status
    
    var isCurrentPageHome: Bool {
        pageVM.currentPage == .Home
    }
    
    var isCurrentPageChat: Bool {
        pageVM.currentPage == .Chat
    }
    
    var isCurrentPageMatches: Bool {
        pageVM.currentPage == .Matches
    }
    
    var isCurrentPageSetting: Bool {
        pageVM.currentPage == .Setting
    }
    
    /// View body
    var body: some View {
        HStack {
            MenuButton(action: {
                if !isCurrentPageHome {
                    pageVM.visit(page: .Home)
                    withAnimation { showMenu = false }
                }
            }, imageStr: "house.fill", labelStr: "Home", isSelect: isCurrentPageHome)
            Spacer()
            MenuButton(action: {
                if !isCurrentPageChat {
                    chatEngine.fetchUserStatus()
                    pageVM.visit(page: .Chat)
                    withAnimation { showMenu = false }
                }
            }, imageStr: "text.bubble.fill", labelStr: "Chat", isSelect: isCurrentPageChat)
            Spacer()
            MenuButton(action: {
                if !isCurrentPageMatches {
                    pageVM.visit(page: .Matches)
                    withAnimation { showMenu = false }
                }
            }, imageStr: "hand.thumbsup.fill", labelStr: "Matches", isSelect: isCurrentPageMatches)
            Spacer()
            MenuButton(action: {
                if !isCurrentPageSetting {
                    pageVM.visit(page: .Setting)
                    withAnimation { showMenu = false }
                }
            }, imageStr: "gearshape.fill", labelStr: "Setting", isSelect: isCurrentPageSetting)
        }
    }
}

/// Menu button
struct MenuButton: View {
    let action: () -> Void /// handle action
    let imageStr: String
    let labelStr: String
    var isSelect: Bool = false
    
    /// View body
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageStr)
                Text(labelStr).font(.footnote)
            }
        }
        .buttonStyle(MenuButtonStyle(isSelect: isSelect))
    }
}

/// MenuButtonStyle
struct MenuButtonStyle: ButtonStyle {
    var isSelect: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelect ? .white : Color("pink_primary"))
            .frame(width: 55)
            .padding(.horizontal, 10)
            .padding(.vertical, 15)
            .background(
                isSelect ?
                configuration.isPressed ? Color("pink_disabled") : Color("pink_primary")
                : configuration.isPressed ? Color("pink_secondary").opacity(0.5) : Color("pink_secondary")
            )
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}
