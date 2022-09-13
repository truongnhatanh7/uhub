//
//  View_UserDetail.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 07/09/2022.
//

import SwiftUI

struct View_UserDetail: View {
    
    @State var isShowSheet:Bool = true
    var isFromMatchPage:Bool
    var user: User
    
    var body: some View {
        ZStack {
            // MARK: Image
            VStack {
                user.image.resizable().frame(width: .infinity, height: 450, alignment: .center)
                
                Spacer()
            }.edgesIgnoringSafeArea(.all)
            
        }.adaptiveSheet(isPresented: .constant(true), content: {
            VStack {
                
                // MARK: Name, major, gpa, chat button
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(user.name).modifier(TextTitle())
                        Text(user.major).font(Font.system(size: 16))
                        Text("GPA: \(user.getFormattedGpa())").font(Font.system(size: 16))
                    }.padding()
                    
                    Spacer()
                    
                    // MARK: BUTTON GROUP
                    HStack {
                        if (isFromMatchPage) {
                            Button(action: {
                                print("Reject this person")
                            }, label: {
                                Image("xButton").padding()
                            }).frame(minWidth: 12, idealWidth: 14, maxWidth: 18, minHeight: 12, idealHeight: 14, maxHeight: 18).padding()
                        }

                        Button(action: {
                            print("Go to chat")
                        }, label: {
                            Image("chatButton").padding()
                        }).frame(minWidth: 12, idealWidth: 14, maxWidth: 18, minHeight: 12, idealHeight: 14, maxHeight: 18).padding()

                    }.padding()
                    
                }.padding(.top, 40)
                
                // MARK: About
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("About").modifier(TextTitle())
                        Text(user.about).font(Font.system(size: 16))
                    }.padding()
                    
                    Spacer()
                }
                
                // MARK: Semester learn
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Semester learned").modifier(TextTitle())
                        Text("\(user.semesterLearned)")
                       
                    }.padding()
                    
                    Spacer()
                }
                
                Spacer()
            }
            
        })
    }
}

struct View_UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        View_UserDetail(isFromMatchPage: true, user: User( id: nil, name: "Bao Nguyen", age: 19, school: "SSET", major: "IT", gpa: 3, semesterLearned: 6, about: "IT Student"))
    }
}
