/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Authors:
 + S3877980 - Ho Le Minh Thach
 + S3878231 - Truong Nhat Anh
 + S3877698 - Nguyen Luu Quoc Bao
 + S3820098  - Le Nguyen Truong An
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgements: Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import SwiftUI
import MediaPlayer

/// This function will handle the toggle sounds
/// - Parameter isOn: if true mean that  the sound will be play else none
func handleSoundToogle(isOn:Bool) {
    print("handle sound")
    let volume = isOn ?  100.0 : 0.0
    (MPVolumeView().subviews.filter{ NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as? UISlider)?.setValue(Float(volume), animated: false)
    print("Set volume to \(volume)")
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
    
    /// This function will switch the page after you press the button
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
    
    /// This function will handle the sounds toggle
    /// - Parameter isOn: true means you will play the sound
    func handleSoundToogle(isOn:Bool) {
        notificationVM.setIsShowSound(value: isOn)
        userAuthManager.currentUserData["isShowSound"] = isOn
    }
    
    /// This function will handle the sounds toggle
    /// - Parameter isOn: true means you will play the sound
    func handleChatToogle(isOn:Bool) {
        notificationVM.setIsShowChatNoti(value: isOn)
        userAuthManager.currentUserData["isShowChatNoti"] = isOn
    }
    
    /// This function will handle the sounds toggle
    /// - Parameter isOn: true means you will play the sound
    func handleNewMatchToogle(isOn:Bool) {
        notificationVM.setIsShowNewMatchNoti(value: isOn)
        userAuthManager.currentUserData["isShowNewMatchNoti"] = isOn
    }
    
    /// This function will render the notification view
    var body: some View {
        VStack(spacing: 10) {
            StandardHeader(title: "Notification") {
                pageVM.visit(page: pageVM.previousPage ?? .Account)
            }
            NotificationOption(label: "sound", toogle: $isSoundToogle, handler: handleSoundToogle)
            NotificationOption(label: "chat", toogle: $isChatToogle, handler: handleChatToogle)
            NotificationOption(label: "new match", toogle: $isNewMatchToogle, isLast: true, handler: handleNewMatchToogle)
            Spacer()
            ButtonView(textContent: "Apply changes", onTap: {
                // call here
                notificationVM.submitData(userAuthManager, callback: switchPageForBtn)
            }).padding()
        }.onAppear {
            print("sound: \((userAuthManager.currentUserData["isShowSound"] as? Bool ?? false))")
            print("chat: \((userAuthManager.currentUserData["isShowChatNoti"] as? Bool ?? false))")
            print("match: \((userAuthManager.currentUserData["isShowNewMatchNoti"] as? Bool ?? false))")
            
            self.isSoundToogle = (userAuthManager.currentUserData["isShowSound"] as? Bool ?? false)
            self.isChatToogle = (userAuthManager.currentUserData["isShowChatNoti"] as? Bool ?? false)
            self.isNewMatchToogle = (userAuthManager.currentUserData["isShowNewMatchNoti"] as? Bool ?? false)
        }
    }
}
