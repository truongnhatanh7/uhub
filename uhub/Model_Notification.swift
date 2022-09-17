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
