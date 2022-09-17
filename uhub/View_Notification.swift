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


func handleChatToogle(isOn:Bool) {
    print("handle chat")
}

func handleNewMatchToogle(isOn:Bool) {
    print("handle new match")
}

struct NotificationView: View {
    
    
    @EnvironmentObject private var notificationSettings:NotificationSettings
    
    @EnvironmentObject var pageVM: PageViewModel
    @EnvironmentObject var userAuthManager: UserAuthManager
    
    @StateObject var notificationVM = NotificationViewModel()

    @State var isSoundToogle:Bool = false
    @State var isVibarateToogle:Bool = false
    @State var isChatToogle:Bool = false
    @State var isNewMatchToogle:Bool = false
    
    private func switchPageForBtn() {
        if userAuthManager.errorMsg == "" {
            if pageVM.isfirstFlow {
                pageVM.visit(page: .EditProfile)
            } else {
                pageVM.visit(page: pageVM.previousPage ?? pageVM.currentPage)
            }
        } else {
            print(userAuthManager.errorMsg)
        }
    }
    
    func handleSoundToogle(isOn:Bool) {
//            print("handle sound")
//
//            let volume = isOn ?  100.0 : 0.0
//
//            (MPVolumeView().subviews.filter{ NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as? UISlider)?.setValue(Float(volume), animated: false)
//
//            print("Set volume to \(volume)")
        
//        notificationVM.$isShowSound = isOn
        notificationVM.setIsShowSound(value: isOn)
        userAuthManager.currentUserData["isShowSound"] = isOn
        }

        func handleChatToogle(isOn:Bool) {
//            print("handle chat")
//            notificationSettings.isShowChat = isOn
//            print(notificationSettings.isShowChat ? "true" : "false")
//            notificationVM.$isShowChatNoti = isOn
            notificationVM.setIsShowChatNoti(value: isOn)
            userAuthManager.currentUserData["isShowChatNoti"] = isOn
        }

        func handleNewMatchToogle(isOn:Bool) {
//            print("handle new match")
//            notificationSettings.isShowNewMatch = isOn
//            print(notificationSettings.isShowNewMatch ? "true" : "false")
            
//            notificationVM.$isShowNewMatchNoti = isOn
            notificationVM.setIsShowNewMatchNoti(value: isOn)
            userAuthManager.currentUserData["isShowNewMatchNoti"] = isOn
        }

    var body: some View {
        VStack(spacing: 10) {

            HStack {
                Text("Notification").fontWeight(.bold).padding(.vertical, 30).font(.system(size: 30))

                Spacer()
            }.padding(.all, 24)


            NotificationOption(label: "sound", toogle: $isSoundToogle, handler: handleSoundToogle)

            NotificationOption(label: "chat", toogle: $isChatToogle, handler: handleChatToogle)
            
            NotificationOption(label: "new match", toogle: $isNewMatchToogle, isLast: true, handler: handleNewMatchToogle)

            Spacer()
            
            ButtonView(textContent: "Apply changes", onTap: {
                
                // call here
                notificationVM.submitData(userAuthManager, callback: switchPageForBtn)
        
            }).padding()
        }.onAppear {
            
            print("render")
            print("sound: \((userAuthManager.currentUserData["isShowSound"] as? Bool ?? false))")
            print("chat: \((userAuthManager.currentUserData["isShowChatNoti"] as? Bool ?? false))")
            print("match: \((userAuthManager.currentUserData["isShowNewMatchNoti"] as? Bool ?? false))")
            
            self.isSoundToogle = (userAuthManager.currentUserData["isShowSound"] as? Bool ?? false)
            self.isChatToogle = (userAuthManager.currentUserData["isShowChatNoti"] as? Bool ?? false)
            self.isNewMatchToogle = (userAuthManager.currentUserData["isShowNewMatchNoti"] as? Bool ?? false)
        }
    }
}

//struct NotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationView().environmentObject(NotificationSettings(isVibarate: true, isShowChat: true, isShowNewMatch: true))
//    }
//}
