//
//  MatchesView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var matchEngine: MatchEngine
    @EnvironmentObject var imageManager: ImageManager
    @State var showMenu = false
    @State var data = [User]()
    @State var showDetailUser = false
    @State var user: User?
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    /// This function will render a list of matches people
    var body: some View {
        VStack {
            GeometryReader  { geometry in
                ScrollView {
                    HeaderHome(title: "Matches")
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(matchEngine.matchesUsers) { user in
                            ZStack {
                                Button {
                                    matchEngine.currentUser = user
                                    showDetailUser = true
                                } label: {
                                    Card(width: geometry.size.width / 2.3, height: geometry.size.height / 3, imageURL: user.id)
                                        .overlay(alignment: .bottom) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text("\(user.name)")
                                                        .font(.title)
                                                    Text("\(user.major)")
                                                        .font(.title3)
                                                }
                                                Spacer()
                                            }
                                            .padding(.bottom, 12)
                                            .padding(.horizontal)
                                            .foregroundColor(.white)
                                        }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .fullScreenCover(isPresented: $showDetailUser) {
                    if let selectedUser = matchEngine.currentUser {
                        View_UserDetail(isShowSheet: $showDetailUser, isFromMatchPage: true, user: selectedUser)
                    }
                }
            }
            
            Spacer()
            if showMenu {
                BottomBar {
                    MenuBar(menuInPage: .Matches, showMenu: $showMenu)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            matchEngine.needReload = true
            withAnimation { showMenu = true }
        }
        .onChange(of: matchEngine.needReload) { newValue in
            if newValue {
                matchEngine.fetchAllMatches {
                    matchEngine.needReload = false
                }
            }
        }
    }
}
