//
//  CongratsView.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 01/09/2022.
//

import SwiftUI

struct CongratsView: View {
    
    @State private var isGoToHome = false
    @EnvironmentObject var pageVM: PageViewModel
    
    var body: some View {
        CongratsModal(isGoToHome: $isGoToHome)
            .onChange(of: isGoToHome) { newValue in
                if newValue {
                    pageVM.visit(page: .Home)
                }
            }
    }
}
