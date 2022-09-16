//
//  View_UserDetail.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 07/09/2022.
//

import SwiftUI

struct View_UserDetail: View {

    @EnvironmentObject var imageManager : ImageManager
    @EnvironmentObject var chatEngine : ChatEngine
    @EnvironmentObject var matchEngine : MatchEngine
    @EnvironmentObject var userAuthManager : UserAuthManager
    @EnvironmentObject var pageVm: PageViewModel
    @Binding var isShowSheet: Bool
    var isFromMatchPage:Bool
    var user: User
    @State var image = Image("User3")
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: Image
            GeometryReader { proxy in
                VStack {
                    Card(width: proxy.size.width, height: proxy.size.height, imageURL: user.id)
                }.edgesIgnoringSafeArea(.all)
                
            }
            if isShowSheet {
                VStack(spacing: 20) {
                    // MARK: Name, major, gpa, chat button
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("\(user.name)")
                                    .font(.largeTitle)
                                Text("\(user.age)")
                                    .font(.title2)
                                Spacer()
                            }
                            .overlay(alignment: .trailing) {
                                Button {
                                    withAnimation {
                                        matchEngine.needReload = false
                                        isShowSheet.toggle()
                                    }
                                } label: {
                                    Image(systemName: "xmark")
                                        .font(.headline)
                                        .padding(5)
                                        .background(Color("pink_primary"))
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                }
                            }
                            Label("\(user.school)", systemImage: "graduationcap.fill")
                                .font(.title3)
                            
                            Text("Major: \(user.major)")
                                .font(Font.system(size: 16))
                            Text("GPA: \(GPAFilterRange(rawValue: user.gpa)?.description ?? "N/A")")
                                .font(Font.system(size: 16))
                            Text("Semester Learned: \(user.semesterLearned)")
                                .font(Font.system(size: 16))
                        }
                        Spacer()
                    }
                    
                    // MARK: About
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("About").modifier(TextTitle())
                            Text(user.about).font(Font.system(size: 16))
                        }
                        Spacer()
                    }
                }
                .padding(.bottom)
                .modifier(OneThirdModalStyle())
                
                // MARK: BUTTON GROUP
                if isFromMatchPage {
                    HStack {
                        Spacer()
                        VStack(spacing: 20) {
                            if (true) {
                                Button(action: {
                                    print("Reject this person")
                                    matchEngine.removeMatch(user: user)
                                    isShowSheet = false
                                }, label: {
                                    Image(systemName: "hand.thumbsdown.fill")
                                        .padding()
                                        .font(.title3)
                                        .foregroundStyle(.white)
                                        .background(Color("pink_primary"))
                                        .clipShape(Circle())
                                })
                            }
                            
                            Button(action: {
                                print("Go to chat")
                                chatEngine.createConversation(recipientId: user.id) {
                                    pageVm.visit(page: .Chat)
                                    isShowSheet = false
                                }
                            }, label: {
                                Image(systemName: "text.bubble.fill")
                                    .padding()
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .background(Color("pink_primary"))
                                    .clipShape(Circle())
                            })
                        }
                        .shadow(radius: 4)
                    }
                    .padding()
                }

            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            chatEngine.imageManager = imageManager
            chatEngine.userAuthManager = userAuthManager
            imageManager.fetchFromUserId(id: user.id) { img in
                self.image = Image(uiImage: img)
            }
        }
    }
}
