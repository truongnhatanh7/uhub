//
//  HomeView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct HomeView: View {
    @State var showMenu = false

    @StateObject var matchEngine = MatchEngine()
    @StateObject var homeVM = HomeViewModel()
    @EnvironmentObject var userAuthManager: UserAuthManager
    @EnvironmentObject var imageManager: ImageManager
    
    var body: some View {
        VStack {
            HeaderHome(title: "Discovery")
            ZStack(alignment: .bottom) {
                ZStack {
                    if let users = homeVM.fetchedUsers {
                        if users.isEmpty {
                            Text("Come back later for more new friends!")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(users.reversed()) { user in
                                StackCard(user: user)
                                    .environmentObject(homeVM)
                            }
                        }
                    }
                }
                .padding()
                .padding(.vertical)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if !homeVM.fetchedUsers.isEmpty || !showMenu {
                    HStack {
                        Spacer()
                        Button { doSwipe() } label: {
                            Label("Dislike", systemImage: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("red_danger"))
                                .padding(18)
                                .background(.bar)
                                .clipShape(Circle())
                        }
                        .shadow(radius: 5)

                        Spacer()
                        Button {
                            doSwipe(rightSwipe: true)
                        } label: {
                            Label("Like", systemImage: "hand.thumbsup.fill")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("green"))
                                .padding(18)
                                .background(.bar)
                                .clipShape(Circle())
                        }
                        .shadow(radius: 5)

                        Spacer()
                    }
                    .foregroundStyle(Color("pink_primary"))
                    .labelStyle(.iconOnly)
                    .disabled(homeVM.fetchedUsers.isEmpty)
                    .transition(.opacity)
                }
            }
            
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
        .task {
            homeVM.fetchData(userAuthManager.currentUserData, imageManager: imageManager)
        }
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = homeVM.fetchedUsers.first else { return }
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}
