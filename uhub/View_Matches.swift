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
