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
            Toggle(isOn: $toogle, label: {
                Text(label.capitalized).fontWeight(.semibold).font(.system(size: 16))
            }).padding(.horizontal, 24).padding(.vertical, 16).toggleStyle(SwitchToggleStyle(tint: Color("Primary"))).onChange(of: toogle) { value in
                
                handler(value)
            }
            
            if !isLast {
                Rectangle().frame(height: 1)
                    .padding(.horizontal, 20).foregroundColor(Color("Gray"))
            }
            
        }
    }
}

struct NotificationOption_Previews: PreviewProvider {
    static var previews: some View {
        NotificationOption(label: "sound", toogle: .constant(false), isLast: false, handler: {isOn in })
    }
}
