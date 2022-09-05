//
//  NotificationModel.swift
//  uhub
//
//  Created by Quoc Bao Nguyen Luu on 05/09/2022.
//

import Foundation
import SwiftUI
import MediaPlayer


class NotificationSettings: ObservableObject {
    @Published var isVibarate: Bool
    @Published var isShowChat: Bool
    @Published var isShowNewMatch: Bool

    init(isVibarate:Bool, isShowChat:Bool, isShowNewMatch:Bool) {
        self.isVibarate = isVibarate
        self.isShowChat = isShowChat
        self.isShowNewMatch = isShowNewMatch
    }
}






