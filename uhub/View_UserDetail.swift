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
    
    /// This function will render the user details
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
                                    chatEngine.deleteConversationInDetailedView(id: user.id)
                                    matchEngine.removeMatch(user: user, userDevice: userAuthManager.currentUserData)
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
                                chatEngine.createConversation(recipientId: user.id) { newConversationId, willFetch in
                                    if willFetch {
                                        chatEngine.fetchConversationForCreation(toBeFetchedConversationId: newConversationId) {
                                            isShowSheet = false
                                            pageVm.visit(page: .Inbox)
                                        }
                                    } else {
                                        isShowSheet = false
                                        pageVm.visit(page: .Inbox)
                                    }                                    
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
