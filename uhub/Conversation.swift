//
//  Conversation.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

import Foundation
import SwiftUI

struct Conversation {
    var conversationId = UUID()
    var imageURL: String
    var name: String
    var latestMessage: String
    var timestamp: Date
    var unread: Bool
    var image: Image?
    
    init(imageURL: String, name: String, latestMessage: String, timestamp: Date, unread: Bool) {
        self.imageURL = imageURL
        self.name = name
        self.latestMessage = latestMessage
        self.timestamp = timestamp
        self.unread = unread
        if imageURL != "" {
            image = Image(imageURL)
        }
    }
}
