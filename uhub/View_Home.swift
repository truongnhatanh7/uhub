//
//  HomeView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct HomeView: View {
    @State var showCongratModal = false
    
    var body: some View {
        if showCongratModal {
            Text("Ditme")
        } else {
            CongratsModal(isGoToHome: $showCongratModal)
        }
    }
}
