//
//  NotificationOption.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 01/09/2022.
//

import SwiftUI

struct NotificationOption: View {
    
    var label:String
    @Binding var toogle:Bool
    var isLast:Bool = false
    var handler: (_ isOn:Bool) -> Void
    
    var body: some View {
        VStack {
            
            Toogle(label: label, toogle: $toogle, handler: handler)
            
            if !isLast {
                Rectangle().frame(height: 1)
                    .padding(.horizontal, 20).foregroundColor(Color("Gray"))
            }
            
        }
    }
}
