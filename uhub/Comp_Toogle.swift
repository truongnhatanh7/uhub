//
//  Toogle.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 05/09/2022.
//

import SwiftUI

struct Toogle: View {
    
    var label:String
    @Binding var toogle:Bool
    var handler: (_ isOn:Bool) -> Void
    
    /// View body
    var body: some View {
        Toggle(isOn: $toogle, label: {
            Text(label.capitalized).fontWeight(.semibold).font(.system(size: 16))
        }).padding(.horizontal, 24).padding(.vertical, 16).toggleStyle(SwitchToggleStyle(tint: Color("Primary"))).onChange(of: toogle) { value in
            
            handler(value)
        }
    }
}
