//
//  MenuBar.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct MenuBar: View {
    @EnvironmentObject var pageVM: PageViewModel
    let menuInPage: Page
    
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
    
    var body: some View {
        HStack {
            MenuButton(action: {
                if !isCurrentPageHome {
                    pageVM.visit(page: .Home)
                }
            }, imageStr: "house.fill", labelStr: "Home", isSelect: isCurrentPageHome)
            Spacer()
            MenuButton(action: {
                if !isCurrentPageChat {
                    pageVM.visit(page: .Chat)
                }
            }, imageStr: "text.bubble.fill", labelStr: "Chat", isSelect: isCurrentPageChat)
            Spacer()
            MenuButton(action: {
                if !isCurrentPageMatches {
                    pageVM.visit(page: .Matches)
                }
            }, imageStr: "hand.thumbsup.fill", labelStr: "Matches", isSelect: isCurrentPageMatches)
            Spacer()
            MenuButton(action: {
                if !isCurrentPageSetting {
                    pageVM.visit(page: .Setting)
                }
            }, imageStr: "gearshape.fill", labelStr: "Setting", isSelect: isCurrentPageSetting)
        }
    }
}

struct MenuButton: View {
    let action: () -> Void
    let imageStr: String
    let labelStr: String
    var isSelect: Bool = false
    
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

struct MenuButtonStyle: ButtonStyle {
    var isSelect: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelect ? .white : Color("pink_primary"))
            .frame(width: 60)
            .padding(.vertical)
            .background(
                isSelect ?
                configuration.isPressed ? Color("pink_disabled") : Color("pink_primary")
                : configuration.isPressed ? Color("pink_secondary").opacity(0.5) : Color("pink_secondary")
            )
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}
