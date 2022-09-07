//
//  ChatEngine.swift
//  uhub
//
//  Created by Truong Nhat Anh on 03/09/2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class ChatEngine: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var messages: [Message] = []
    @Published var conversations: [Conversation] = []
    @Published var currentConversation: Conversation?
    @Published var isProcessing: Bool = false
    @Published var lastMessageId: String = ""
    
    private var messagesListener: ListenerRegistration?
    private var conversationListener: ListenerRegistration?
    private var currentLimit = 14
    
    deinit {
        print("Deinit listeners")
        conversationListener?.remove()
        messagesListener?.remove()
    }

    func loadConversation() {
        if let currentConversation = currentConversation {
            self.isProcessing = true
            messagesListener = db.collection("messages")
                .whereField("conversationId", isEqualTo: currentConversation.conversationId)
                .addSnapshotListener
                    { (querySnapshot, error) in
                        guard (querySnapshot?.documents) != nil else {
                            print("Error fetching documents: \(error!)")
                            self.isProcessing = false
                            return
                        }
                        
                        self.loadMessages()
                        withAnimation {
                            self.isProcessing = false
                        }
                    }
        }
    }
    
    func setCurrentLimit(limit: Int) {
        self.currentLimit = limit
    }
    
     func loadMessages() {
         if let currentConversation = currentConversation {
             db.collection("messages").whereField("conversationId", isEqualTo: currentConversation.conversationId).order(by: "timestamp", descending: true).limit(to: self.currentLimit).getDocuments() { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.messages = documents.map { (queryDocumentSnapshot) -> Message in
                        let data = queryDocumentSnapshot.data()
                        let messageId = queryDocumentSnapshot.documentID
                        let ownerId = data["ownerId"] as? String ?? ""
                        let conversationId = data["conversationId"] as? String ?? ""
                        let content = data["content"] as? String ?? ""
                        let timestamp = data["timestamp"] as? Timestamp // Timestamp is a Firebase date datatype -> convert to Date for Swift
                        return Message(id: messageId, ownerId: ownerId, conversationId: conversationId, content: content, timestamp: timestamp?.dateValue() ?? Date())
                    }

                    self.messages = self.messages.reversed()
                    
                    // For scolling to latest message
                    if let latestMsg = self.messages.last {
                        self.lastMessageId = latestMsg.id
                    }
                }
            }
         }
         
    }
    
    func loadChatList(){
        print("Start to load chat list") // TODO: Load chat that belongs to that user (save in user db)
        conversationListener = db.collection("conversations").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "-1").addSnapshotListener { (querySnapshot, err) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                DispatchQueue.main.async {
                    self.conversations = documents.map { (queryDocumentSnapshot) -> Conversation in
                        let data = queryDocumentSnapshot.data()
                        let conversationId = queryDocumentSnapshot.documentID
                        let latestMessage = data["latestMessage"] as? String ?? ""
                        let timestamp = data["timestamp"] as? Date ?? Date()
                        let unread = data["unread"] as? Bool ?? false
                        let users = data["users"] as? [String] ?? []
                        let latestMessageSender = data["latestMessageSender"] as? String ?? ""
                        return Conversation(conversationId: conversationId, latestMessage: latestMessage, timestamp: timestamp, unread: unread, users: users, latestMessageSender: latestMessageSender, name: "")
                    }
                }
            }
    }
    
    func sendMessage(content: String) {
        if let currentConversation = currentConversation {
            let docData: [String: Any] = [
                "messageId": UUID().uuidString,
                "ownerId": Auth.auth().currentUser?.uid ?? "-1",
                "conversationId": currentConversation.conversationId,
                "content": content,
                "timestamp": Date()
            ]
            db.collection("messages").document(UUID().uuidString).setData(docData)
            
            if let currentUser = Auth.auth().currentUser {
                db.collection("conversations").document(currentConversation.conversationId).updateData([ // Updatte latest message when sending new message from both sides
                    "latestMessage": content,
                    "timestamp": Date(),
                    "unread": true,
                    "latestMessageSender": currentUser.uid
                ])
            }

            
        }


    }
    
    func setRead() {
        if let currentConversation = currentConversation {
            if Auth.auth().currentUser?.uid != currentConversation.latestMessageSender { // If unread == false, do not call this
                if currentConversation.unread {
                    db.collection("conversations").document(currentConversation.conversationId).updateData([
                        "timestamp": Date(),
                        "unread": false
                    ])
                }
            }
        }
    }
}
