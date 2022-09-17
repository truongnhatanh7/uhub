//
//  MatchCongrat.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 17/09/2022.
//

import SwiftUI

struct MatchCongrat: View {
    @Binding var showIsMatchUser: Bool
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all).opacity(0.7)
            
            // MARK: Modal
            VStack(spacing: 24) {
                
                Image("CongratsIcon").resizable().modifier(CongratsLogoStyle())
                
                
                Text("Great! It's a match.")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .modifier(CongratsTextStyle())
                
                Text("Don't keep them waiting, say hello now!")
                    .font(.system(size: 16))
                    .modifier(CongratsTextStyle())
                
                Button {
                    showIsMatchUser = false
                } label: {
                    VStack {
                        Text("Go to Chat")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                    }
                    .modifier(CongratsButtonStyle())
                }
                
            }
            .modifier(ModalStyle())
        }
    }
}
