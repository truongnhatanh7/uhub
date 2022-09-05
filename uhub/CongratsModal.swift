//
//  CongratsModal.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 01/09/2022.
//

import SwiftUI

struct CongratsModal: View {
    @Binding var isGoToHome:Bool
    
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all).opacity(0.7)
            
            
            // MARK: Modal
            VStack(spacing: 24) {
                
                Image("CongratsIcon").resizable().scaledToFit().frame(minWidth: 170, idealWidth: 180, maxWidth: 190, minHeight: 180, idealHeight: 186, maxHeight: 190)
                
                
                Text("Great \n Your account has been \n created successfully").fontWeight(.semibold).multilineTextAlignment(.center).lineLimit(3).font(.system(size: 24)).foregroundColor(Color("pink_primary")).lineSpacing(10)
                
                Button(action: { isGoToHome = true }) {
                    VStack {
                        Text("Go to Home").fontWeight(.semibold).font(.system(size: 20))
                    }.frame(minWidth: 285, idealWidth: 292, maxWidth: 300, minHeight: 50, idealHeight: 55, maxHeight: 60).background(LinearGradient(gradient: Gradient(colors: [Color("pink_disabled"), Color("pink_primary")]), startPoint: .topLeading, endPoint: .bottomTrailing)).foregroundColor(.white).cornerRadius(32)
                }
                
            }.frame(minWidth: 320, idealWidth: 350, maxWidth: 360, minHeight: 450, idealHeight: 460, maxHeight: 480).background(.white).cornerRadius(24).padding()
        }
    }
}

struct CongratsModal_Previews: PreviewProvider {
    static var previews: some View {
        CongratsModal(isGoToHome: .constant(false))
    }
}
