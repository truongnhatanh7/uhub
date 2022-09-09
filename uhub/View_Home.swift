//
//  HomeView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct HomeView: View {
    @State var showMenu = false

    @StateObject var homeVM = HomeViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image("Icon")
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("Discovery")
                    .font(.title.bold())
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.horizontal)
            ZStack(alignment: .bottom) {
                ZStack {
                    if let users = homeVM.displayingUsers {
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
                
                HStack {
                    Spacer()
                    Button { doSwipe() } label: {
                        Label("Dislike", systemImage: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .shadow(radius: 5)
                            .padding(18)
                            .background(.bar)
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button { doSwipe(rightSwipe: true) } label: {
                        Label("Like", systemImage: "hand.thumbsup.fill")
                            .font(.system(size: 20, weight: .bold))
                            .shadow(radius: 5)
                            .padding(18)
                            .background(.bar)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .foregroundStyle(Color("pink_primary"))
                .labelStyle(.iconOnly)
                .disabled(homeVM.displayingUsers?.isEmpty ?? false)
                .opacity(homeVM.displayingUsers?.isEmpty ?? false ? 0.6 : 1)
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
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = homeVM.displayingUsers?.first else { return }
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}
