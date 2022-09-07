//
//  Conversation.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

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
