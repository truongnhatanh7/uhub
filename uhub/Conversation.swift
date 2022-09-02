//
//  Conversation.swift
//  uhub
//
//  Created by Truong Nhat Anh on 01/09/2022.
//

import Foundation
import SwiftUI

struct Conversation : Hashable {
    var conversationId : Int
    var imageURL: String
    var name: String
    var latestMessage: String
    var timestamp: Date
    var unread: Bool
//    private var imageName: String
//    var image: Image {
//        if imageName == "" {
//
//        }
//        Image(imageName)
//    }
    
}
