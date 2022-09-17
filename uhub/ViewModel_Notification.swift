/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Ho Le Minh Thach
 ID: s3877980
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import Foundation
import UIKit
import SwiftUI
import FirebaseStorage

@MainActor class NotificationViewModel: ObservableObject {
    @Published var isShowSound: Bool = false
    @Published var isShowChatNoti: Bool = false
    @Published var isShowNewMatchNoti: Bool = false
    
    
    /// This function used to submit data
    func submitData(_ manager: UserAuthManager, callback: @escaping () -> ()) {
        manager.updateProfileInfo(updatedData: [
            "isShowSound": isShowSound,
            "isShowChatNoti": isShowChatNoti,
            "isShowNewMatchNoti": isShowNewMatchNoti,
        ], callback: callback)
    }
    
    public func setIsShowSound(value:Bool) {
        isShowSound = value
    }
    
    public func setIsShowChatNoti(value:Bool) {
        isShowChatNoti = value
    }
    
    public func setIsShowNewMatchNoti(value:Bool) {
        isShowNewMatchNoti = value
    }
}



