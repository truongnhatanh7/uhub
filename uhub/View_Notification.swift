//
//  NotificationView.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 01/09/2022.
//

import SwiftUI
import MediaPlayer


struct NotificationView: View {
    
    @EnvironmentObject private var notificationSettings:NotificationSettings
    @EnvironmentObject var pageVM: PageViewModel
    
    @State var isSoundToogle:Bool = false
    @State var isVibarateToogle:Bool = false
    @State var isChatToogle:Bool = false
    @State var isNewMatchToogle:Bool = false
    
    func handleSoundToogle(isOn:Bool) {
        print("handle sound")
        
        let volume = isOn ?  100.0 : 0.0
        
        (MPVolumeView().subviews.filter{ NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as? UISlider)?.setValue(Float(volume), animated: false)
        
        print("Set volume to \(volume)")
    }
    
    func handleVibarateToogle(isOn:Bool) {
        print("handle vibarate")
        notificationSettings.isVibarate = isOn
        print(notificationSettings.isVibarate ? "true" : "false")
        
    }
    
    func handleChatToogle(isOn:Bool) {
        print("handle chat")
        notificationSettings.isShowChat = isOn
        print(notificationSettings.isShowChat ? "true" : "false")
    }
    
    func handleNewMatchToogle(isOn:Bool) {
        print("handle new match")
        notificationSettings.isShowNewMatch = isOn
        print(notificationSettings.isShowNewMatch ? "true" : "false")
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 10) {
                        NotificationOption(label: "sound", toogle: $isSoundToogle, handler: handleSoundToogle)
                        NotificationOption(label: "vibarate", toogle: $isVibarateToogle, handler: handleVibarateToogle)
                        NotificationOption(label: "chat", toogle: $isChatToogle, handler: handleChatToogle)
                        NotificationOption(label: "new match", toogle: $isNewMatchToogle, isLast: true, handler: handleNewMatchToogle)
                    }
                    .padding(.top, 60)
                }
                StandardHeader(title: "Notification") {
                    pageVM.visit(page: .FilterProfile)
                }
            }
            BottomBar {
                ButtonView(textContent: "Next", onTap: {
                    pageVM.visit(page: .Home)
                })
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
