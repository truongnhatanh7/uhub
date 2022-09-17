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

struct ContentView: View {
    @StateObject private var pageVM = PageViewModel()
    @StateObject private var userAuthManager = UserAuthManager()
    @StateObject private var chatEngine = ChatEngine()
    @StateObject private var notificationManager = NotiManager()
    @StateObject private var matchEngine = MatchEngine()
    @StateObject private var imageManager = ImageManager()
    
    /// It will render the main content of the app
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            Group {
                switch pageVM.currentPage {
                case .Splash:
                    SplashView()
                case .Notification:
                    NotificationView()
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
                        .transition(.opacity.combined(with: .offset(y: -40)).animation(.linear(duration: 0.1)))
                }
                
            }
            .environmentObject(pageVM)
            .environmentObject(userAuthManager)
            .environmentObject(chatEngine)
            .environmentObject(notificationManager)
            .environmentObject(matchEngine)
            .environmentObject(imageManager)
            .environmentObject(NotificationSettings(isVibarate: true, isShowChat: true, isShowNewMatch: true))
            .onAppear {
                notificationManager.requestNotiAuth()
            }
        }
    }
}
