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
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Label("Back", systemImage: "arrow.left")
                    .labelStyle(.iconOnly)
                    .tint(Color("pink_primary"))
            }
            Text(title).font(.headline)
            Spacer()
        }
        .padding()
        .background(.bar)
    }
}

struct StandardHeader_Previews: PreviewProvider {
    static var previews: some View {
        StandardHeader(title: "Fill Your Profile")
            .environmentObject(PageViewModel())
            .previewLayout(.sizeThatFits)
    }
}
