//
//  NotificationView.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 01/09/2022.
//

import SwiftUI
import MediaPlayer

func handleSoundToogle(isOn:Bool) {
    print("handle sound")
    
    let volume = isOn ?  100.0 : 0.0
    
    (MPVolumeView().subviews.filter{ NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as? UISlider)?.setValue(Float(volume), animated: false)
    
    print("Set volume to \(volume)")
}

func handleVibarateToogle(isOn:Bool) {
    print("handle vibarate")
}

func handleChatToogle(isOn:Bool) {
    print("handle chat")
}

func handleNewMatchToogle(isOn:Bool) {
    print("handle new match")
}

struct NotificationView: View {
    
    @State var isSoundToogle:Bool = false
    @State var isVibarateToogle:Bool = false
    @State var isChatToogle:Bool = false
    @State var isNewMatchToogle:Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Text("Notification").fontWeight(.bold).padding(.vertical, 30).font(.system(size: 30))
                
                Spacer()
            }.padding(.all, 24)
            
            
            NotificationOption(label: "sound", toogle: $isSoundToogle, handler: handleSoundToogle)
            NotificationOption(label: "vibarate", toogle: $isVibarateToogle, handler: handleVibarateToogle)
            NotificationOption(label: "chat", toogle: $isChatToogle, handler: handleChatToogle)
            NotificationOption(label: "new match", toogle: $isNewMatchToogle, isLast: true, handler: handleNewMatchToogle)
            
            Spacer()
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
