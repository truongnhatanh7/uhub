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
    
    @State private var isLoading = true
    
    //    @State var time = Date()
    //    let formatter = DateFormatter()
    
    var body: some View {
        VStack {
            HeaderHome(title: "Discovery")
            ZStack(alignment: .bottom) {
                if !isLoading {
                    Group {
                        ZStack(alignment: .bottom) {
                            ZStack {
                                if let users = homeVM.fetchedUsers {
                                    if users.isEmpty {
                                        Text("Come back for more friends!")
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
                            .padding(.bottom, 40)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            if !homeVM.fetchedUsers.isEmpty || !showMenu {
                                HStack {
                                    Spacer()
                                    Button { doSwipe() } label: {
                                        Label("Nope", systemImage: "xmark")
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
                                .padding()
                                .foregroundStyle(Color("pink_primary"))
                                .labelStyle(.iconOnly)
                                .disabled(homeVM.fetchedUsers.isEmpty)
                                .transition(.opacity)
                            }
                        }                    }
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        ProgressView("Loading users ...")
                            .progressViewStyle(.circular)
                            .tint(Color("pink_primary"))
                            .foregroundColor(Color("pink_primary"))
                            .task {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    self.isLoading.toggle()
                                }
                            }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
