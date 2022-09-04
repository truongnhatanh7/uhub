//
//  ChatEngine.swift
//  uhub
//
//  Created by Truong Nhat Anh on 03/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class ChatEngine: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var messages: [Message] = []
    @Published var conversations: [Conversation] = []
    @Published var currentConversation: String = "-1"
    @Published var lastMessageId: String = "-1"
    @Published var lastMessageSenderId: String = "-1"
    private var messagesListener: ListenerRegistration?
    private var conversationListener: ListenerRegistration?
    @Published var currentUnread: Bool = false

    deinit {
        conversationListener?.remove()
        messagesListener?.remove()
    }

    func loadConversation() { // LOad messages in that particular conversation
        print("[Load Conversation] invoked")
        messagesListener = db.collection("messages")
            .whereField("conversationId", isEqualTo: currentConversation)
            .addSnapshotListener
                { (querySnapshot, error) in
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
                        self.messages.sort { $0.timestamp < $1.timestamp } // Sort by timestamp
                        
                        // For scolling to latest message
                        if let latestMsg = self.messages.last {
                            self.lastMessageId = latestMsg.id
                            self.lastMessageSenderId = latestMsg.ownerId
                            self.updateChatList(content: latestMsg.content) // Everytime current conversation has new update -> update conversation data
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
                        return Conversation(conversationId: conversationId, latestMessage: latestMessage, timestamp: timestamp, unread: unread, users: users)
                    }
                }
            }
        
    }
    
    func sendMessage(content: String) {
        let docData: [String: Any] = [
            "messageId": UUID().uuidString,
            "ownerId": Auth.auth().currentUser?.uid ?? "-1",
            "conversationId": currentConversation,
            "content": content,
            "timestamp": Date()
        ]
        db.collection("messages").document(UUID().uuidString).setData(docData)
        db.collection("conversations").document(currentConversation).updateData([ // Updatte latest message when sending new message from both sides
            "latestMessage": content,
            "timestamp": Date(),
            "unread": true
        ])
    }
    
    private func updateChatList(content: String) {
        if Auth.auth().currentUser?.uid != lastMessageSenderId && currentUnread { // If unread == false, do not call this
            db.collection("conversations").document(currentConversation).updateData([
                "latestMessage": content,
                "timestamp": Date(),
                "unread": false
            ])
            currentUnread = false
        }
    }
}
