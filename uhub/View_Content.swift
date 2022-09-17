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
    @StateObject private var matchEngine = MatchEngine()
    @StateObject private var imageManager = ImageManager()
    
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
                    .transition(.move(edge: .trailing).combined(with: .opacity).animation(.linear(duration: 0.1)))
            case .FilterProfile:
                FilterProfileView()
                    .transition(.move(edge: .trailing).combined(with: .opacity).animation(.linear(duration: 0.1)))
            case .Security:
                EmptyView()
            case .Congrat:
                CongratsView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            case .Setting:
                SettingView()
                    .transition(.opacity.combined(with: .offset(y: -40)).animation(.linear(duration: 0.1)))
            case .Account:
                ManageAccountView()
                    .transition(.move(edge: .trailing).combined(with: .opacity).animation(.linear(duration: 0.1)))
            case .Logout:
                EmptyView()
            case .Home:
                HomeView()
                    .transition(.opacity.combined(with: .offset(y: -40)).animation(.linear(duration: 0.1)))
            case .Detail:
                EmptyView()
            case .Matches:
                MatchesView()
                    .transition(.opacity.combined(with: .offset(y: -40)).animation(.linear(duration: 0.1)))
            case .Chat:
                ChatListView()
                    .transition(.opacity.combined(with: .offset(y: -40)).animation(.linear(duration: 0.1)))
            case .Inbox:
                InboxView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
            
        }
        .environmentObject(pageVM)
        .environmentObject(userAuthManager)
        .environmentObject(chatEngine)
        .environmentObject(notificationManager)
        .environmentObject(matchEngine)
        .environmentObject(imageManager)
        .onAppear {
            notificationManager.requestNotiAuth()
        }
    }
}
