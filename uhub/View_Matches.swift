//
//  MatchesView.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 08/09/2022.
//

import SwiftUI

struct MatchesView: View {
    @State var showMenu = false
    private var data = Array(1...20)

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        VStack {
            GeometryReader  { geometry in
                ScrollView {
                    HeaderHome(title: "Matches")
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(data, id: \.self) { number in
                            ZStack {
                                Card(image: Image("User4"), width: geometry.size.width / 2.2, height: geometry.size.height / 3)
                            }
                        }
                    }
                    .padding()
                }
            }
            Spacer()
            if showMenu {
                BottomBar {
                    MenuBar(menuInPage: .Matches, showMenu: $showMenu)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            withAnimation { showMenu = true }
        }
    }
}
