//
//  MatchesView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct MatchesView: View {
    @State var showMenu = false
    private var data = Array(1...20)
    @State var showDetailUser = false
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        VStack {
            GeometryReader  { geometry in
                ScrollView {
                    HeaderHome(title: "Matches")
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(data, id: \.self) { number in
                            ZStack {
                                Button {
                                    showDetailUser = true
                                } label: {
                                    Card(image: Image("User4"), width: geometry.size.width / 2.2, height: geometry.size.height / 3)
                                        .overlay(alignment: .bottom) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text("Name")
                                                        .font(.title)
        
                                                    Text("dfasdf")
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
                    .padding()
                }
                .fullScreenCover(isPresented: $showDetailUser) {
                    View_UserDetail(isShowSheet: $showDetailUser, isFromMatchPage: true, user: User(id: "daf", name: "fdksaljfa", age: 2, school: "fdkf", major: "fdkj", gpa: 2, semesterLearned: 3, about: "fd", image: Image("User3")))
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
            withAnimation { showMenu = true }
        }
    }
}
