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
                
                Image("CongratsIcon").resizable().modifier(CongratsLogoStyle())
                
                
                Text("Great \n Your account has been \n created successfully").fontWeight(.bold).font(.system(size: 24)).modifier(CongratsTextStyle())
                
                Button(action: { isGoToHome = true }) {
                    VStack {
                        Text("Go to Home").fontWeight(.semibold).font(.system(size: 20))
                    }.modifier(CongratsButtonStyle())
                }
                
            }
            .modifier(ModalStyle())
        }
    }
}

struct CongratsModal_Previews: PreviewProvider {
    static var previews: some View {
        CongratsModal(isGoToHome: .constant(false))
    }
}
