//
//  SplashView.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 01/09/2022.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive:Bool = false
    @State var isShowAnimation:Bool = false
    
    var body: some View {
        VStack {
            if isActive {
                TempHomeView()
            } else {
                Image("logo").resizable().scaledToFit().frame(minWidth: 250, idealWidth: 280, maxWidth: 300).padding().offset(y: isShowAnimation ? 0 : 500).animation(Animation.linear(duration: 1.0), value: isShowAnimation).opacity(isShowAnimation ? 1.0 : 0.0).animation(Animation.linear(duration: 2.0), value: isShowAnimation)
            }
        }.onAppear {
            
            // load necessary data here
            
            isShowAnimation = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                
                withAnimation {
                    self.isActive = true
                }
            }
            
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
