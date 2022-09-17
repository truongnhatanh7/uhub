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

struct Conversation : Hashable, Codable {
    var conversationId : String
    var latestMessage: String
    var timestamp: Date
    var unread: Bool
    var users: [String]
    var userNames: [String : String]
    var latestMessageSender: String
    var name: String
}
