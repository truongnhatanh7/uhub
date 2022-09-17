//
//  ViewModel_Notification.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 17/09/2022.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseStorage

@MainActor class NotificationViewModel: ObservableObject {
    @Published var isShowSound: Bool = false
    @Published var isShowChatNoti: Bool = false
    @Published var isShowNewMatchNoti: Bool = false

    
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
                


