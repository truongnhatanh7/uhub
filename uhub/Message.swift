//
//  Message.swift
//  uhub
//
//  Created by Truong Nhat Anh on 02/09/2022.
//

import Foundation

struct Message: Identifiable, Hashable, Codable, Equatable {
    var id: String
    var ownerId: String // To render message row
    var conversationId: String // To query DB -> Messages list
    var content: String
    var timestamp: Date
}




