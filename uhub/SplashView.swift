//
//  SplashView.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 01/09/2022.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var pageVM: PageViewModel
    @State var isActive:Bool = false
    @State var isShowAnimation:Bool = false
    @State var scaleValue = CGFloat(0.75)
    
    var body: some View {
        VStack {
            Image("Logo").resizable().modifier(LogoSplashScreenModifier()).opacity(isShowAnimation ? 1.0 : 0.0).scaleEffect(scaleValue).animation(Animation.linear(duration: 2.0), value: isShowAnimation)
            
        }.onAppear {
            
            // load necessary data here
            
            isShowAnimation = true
            scaleValue = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                pageVM.visit(page: .SignUp)
            }
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(PageViewModel())
    }
}
