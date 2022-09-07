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
    
    var body: some View {
        ZStack {
            // MARK: Image
            VStack {
                Image("user").resizable().modifier(DetailImage())
                
                Spacer()
            }.edgesIgnoringSafeArea(.all)
            
        }.adaptiveSheet(isPresented: .constant(true), content: {
            VStack {
                
                // MARK: Name, major, gpa, chat button
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Adam Smith").modifier(TextTitle())
                        Text("Software Engineer").font(Font.system(size: 16))
                        Text("GPA: 3.86").font(Font.system(size: 16))
                    }.padding()
                    
                    Spacer()
                    
                    // icon
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
                        Text("I am a senior student at RMIT. My strengths are machine learning and data visualization. I know a bit about web development and finding a team for my capstone. ").font(Font.system(size: 16))
                    }.padding()
                    
                    Spacer()
                }
                
                // MARK: Course taking
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Studying this semester").modifier(TextTitle())
                        
                        HStack {
                            VStack(alignment: .leading) {
                              
                                Comp_Course(name: "iOS Development")
                                
                                Comp_Course(name: "Software Engineering Design")
                                
                                Comp_Course(name: "Engineering Computing 1")
                        
                            }
                            
                            Spacer()
                        }
                       
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
        View_UserDetail(isFromMatchPage: true)
    }
}
