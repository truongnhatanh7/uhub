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
    @StateObject private var notificationManager = NotiManager()
    
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
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .FilterProfile:
                FilterProfileView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .Notification:
                NotificationView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .Security:
                EmptyView()
            case .Congrat:
                CongratsView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .Setting:
                SettingView()
                    .transition(
                        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
                    )
            case .Logout:
                EmptyView()
            case .Home:
                HomeView()
                    .transition(
                        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
                    )
            case .Detail:
                EmptyView()
            case .Matches:
                MatchesView()
                    .transition(
                        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
                    )
            case .Chat:
                ChatListView()
                    .transition(
                        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
                    )
            case .Inbox:
                InboxView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
            
        }
        .environmentObject(pageVM)
        .environmentObject(userAuthManager)
        .environmentObject(chatEngine)
        .environmentObject(notificationManager)
        .onAppear {
            notificationManager.requestNotiAuth()
        }
    }
}
