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
    
    init() {
    }
    
    func loadConversation() {
        db.collection("messages")
            .whereField("conversationId", isEqualTo: currentConversation)
            .addSnapshotListener
                { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("Error fetching documents: \(error!)")
                        return
                    }
                    print("[loadConversation()] listener is working")
                    DispatchQueue.main.async {
                        self.messages = []
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
                        if let lastId = self.messages.last?.id {
                            self.lastMessageId = lastId
                        }
                    }
                }
    }
    
    func loadChatList(){
        print("Start to load chat list")
            db.collection("conversations").addSnapshotListener { (querySnapshot, err) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                DispatchQueue.main.async {
                    self.conversations = documents.map { (queryDocumentSnapshot) -> Conversation in
                        let data = queryDocumentSnapshot.data()
                        let conversationId = queryDocumentSnapshot.documentID
                        let latestMessage = data["lastMessageSent"] as? String ?? ""
                        let timestamp = data["lastMessageTimestamp"] as? Date ?? Date()
                        let unread = data["unread"] as? Bool ?? false
                        let userA = data["userA"] as? String ?? ""
                        let userB = data["userB"] as? String ?? ""
                        return Conversation(conversationId: conversationId, latestMessage: latestMessage, timestamp: timestamp, unread: unread, userA: userA, userB: userB)
                    }
                }
                print("Done loading chat list")
                print(self.conversations)
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
        
        // Update chat list view
        updateAfterSendMessage(content: content)
    }
    
    private func updateAfterSendMessage(content: String) {
        let toBeUpdatedConversationData: [String: Any] = [
            "lastMessageSent": content,
            "lastMessageTimestamp": Date()
        ]
        self.db.collection("conversations").document(self.currentConversation).updateData(toBeUpdatedConversationData)
    }
    
    func getConversations() -> [Conversation] {
        return self.conversations
    }
    
    
}
