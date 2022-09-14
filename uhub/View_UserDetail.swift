//
//  View_UserDetail.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 07/09/2022.
//

import SwiftUI

struct View_UserDetail: View {
    
    @Binding var isShowSheet: Bool
    var isFromMatchPage:Bool
    var user: User
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: Image
            GeometryReader { proxy in
                VStack {
                    Card(image: user.image, width: proxy.size.width, height: proxy.size.height)
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
                            Text("GPA: \(GPARange(rawValue: user.gpa)?.description ?? "N/A")")
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
                .modifier(OneThirdModalStyle())
                
                // MARK: BUTTON GROUP
                HStack {
                    Spacer()
                    VStack(spacing: 20) {
                        if (true) {
                            Button(action: {
                                print("Reject this person")
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
}
