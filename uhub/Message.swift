//
//  Message.swift
//  uhub
//
//  Created by Truong Nhat Anh on 02/09/2022.
//

import Foundation

struct Message: Hashable, Codable, Equatable {
    var messageId: Int
    var ownerId: Int // To render message row
    var conversationId: Int // To query DB -> Messages list
    var content: String
    var timestamp: Date
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: self.timestamp)
    }
}


