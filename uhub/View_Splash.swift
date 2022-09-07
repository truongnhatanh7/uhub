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
   
    
    var body: some View {
        VStack {
            Image("Logo").resizable().modifier(LogoSplashScreenModifier()).opacity(isShowAnimation ? 1.0 : 0.0).animation(Animation.linear(duration: 2.0), value: isShowAnimation)
            
        }.onAppear {
            
            isShowAnimation = true
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
