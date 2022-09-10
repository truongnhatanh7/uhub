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
            VStack {
                StandardHeader(title: "Notification") {
                    if pageVM.isfirstFlow {
                        pageVM.visit(page: .FilterProfile)
                    } else {
                        pageVM.visit(page: pageVM.previousPage ?? .Notification)
                    }
                }
                List {
                    Toogle(label: "Sound", toogle: $isSoundToogle, handler: handleSoundToogle)
                    Toogle(label: "Vibarate", toogle: $isVibarateToogle, handler: handleVibarateToogle)
                    Toogle(label: "Chat", toogle: $isChatToogle, handler: handleChatToogle)
                    Toogle(label: "New match", toogle: $isNewMatchToogle, handler: handleNewMatchToogle)
                }
                .listStyle(.plain)
            }
            BottomBar {
                ButtonView(textContent: "Next", onTap: {
                    pageVM.visit(page: .Congrat)
                })
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
