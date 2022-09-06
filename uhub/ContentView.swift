//
//  ContentView.swift
//  uhub
//
//  Created by Truong Nhat Anh on 30/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var pageVM = PageViewModel()
    @StateObject private var userAuthManager = UserAuthManager()
    @StateObject private var chatEngine = ChatEngine()
    
    var body: some View {
        Group {
            switch pageVM.currentPage {
            case .Splash:
                SplashView()
            case .SignUp:
                SignupScreenView()
                    .transition(
                        .asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
                    )
            case .SignIn:
                SigninScreenView()
                    .transition(
                        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
                    )
            case .EditProfile:
                EditProfileView()
                    .transition(.move(edge: .trailing))
            case .FilterProfile:
                EmptyView()
            case .Notification:
                EmptyView()
            case .Security:
                EmptyView()
            case .SetupComplete:
                EmptyView()
            case .Setting:
                EmptyView()
            case .Logout:
                EmptyView()
            case .Home:
                EmptyView()
            case .Detail:
                EmptyView()
            case .Matches:
                EmptyView()
            case .Chat:
                ChatListView()
            case .Inbox:
                InboxView()
            }
        
        }
        .environmentObject(pageVM)
        .environmentObject(userAuthManager)
        .environmentObject(chatEngine)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
