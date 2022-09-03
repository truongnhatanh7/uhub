//
//  Message.swift
//  uhub
//
//  Created by Truong Nhat Anh on 02/09/2022.
//

import Foundation

struct Message: Hashable, Codable, Equatable {
    var messageId: String
    var ownerId: String // To render message row
    var conversationId: String // To query DB -> Messages list
    var content: String
    var timestamp: Date
}




