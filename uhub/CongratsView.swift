//
//  CongratsView.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 01/09/2022.
//

import SwiftUI

struct CongratsView: View {
    
    @State private var isGoToHome = false
    
    var body: some View {
        if isGoToHome {
            TempHomeView()
        } else {
            CongratsModal(isGoToHome: $isGoToHome)
        }
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratsView()
    }
}
