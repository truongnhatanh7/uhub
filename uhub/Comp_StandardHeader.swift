//
//  StandardHeader.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 03/09/2022.
//

import SwiftUI

struct StandardHeader: View {
    @EnvironmentObject var pageMV: PageViewModel
    let title: String
    var showReturn: Bool = true
    let action: () -> Void
    
    var body: some View {
        HStack {
            if showReturn {
                Button(action: action) {
                    Label("Back", systemImage: "arrow.left")
                        .labelStyle(.iconOnly)
                        .tint(Color("pink_primary"))
                }
            }
            Text(title).font(.headline)
            Spacer()
        }
        .padding()
        .background(Color("background"))
    }
}

struct StandardHeader_Previews: PreviewProvider {
    static var previews: some View {
        StandardHeader(title: "Fill Your Profile", action: {})
            .environmentObject(PageViewModel())
            .previewLayout(.sizeThatFits)
    }
}
