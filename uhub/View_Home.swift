//
//  HomeView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            BottomBar {
                MenuBar(menuInPage: .Home)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
