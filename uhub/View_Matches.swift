//
//  MatchesView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var matchEngine: MatchEngine
    @State var showMenu = false
    @State var data = [User]()
    @State var showDetailUser = false
    @State var user: User?
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack {
            GeometryReader  { geometry in
                ScrollView {
                    HeaderHome(title: "Matches")
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(data) { user in
                            ZStack {
                                Button {
                                    matchEngine.currentUser = user
                                    showDetailUser = true
                                } label: {
                                    Card(image: Image("User4"), width: geometry.size.width / 2.5, height: geometry.size.height / 3)
                                        .overlay(alignment: .bottom) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text("\(user.name)")
                                                        .font(.title)
                                                    Text("\(user.major)")
                                                        .font(.title3)
                                                }
                                            }
                                            .padding(.bottom, 12)
                                            .padding(.horizontal, 4)
                                            .foregroundColor(.white)
                                        }
                                }
                            }
                        }
                    }
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
            matchEngine.fetchAllMatches {
                self.data = matchEngine.matchesUsers.map({ element in
                    return User(id: element.id, name: element.name, age: element.age, school: element.school, major: element.major, gpa: element.gpa, semesterLearned: element.semesterLearned, about: element.about, image: Image("User3"))
                })
            }
            withAnimation { showMenu = true }
        }
    }
}
