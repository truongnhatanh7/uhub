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
    @Published var currentConversation: String = "1"
    
    init() {
    }
    

    
    func loadConversation() {
        db.collection("messages")
            .addSnapshotListener
                { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("Error fetching documents: \(error!)")
                        return
                    }
                    DispatchQueue.main.async {
                        self.messages = []
                        self.messages = documents.map { (queryDocumentSnapshot) -> Message in
                            let data = queryDocumentSnapshot.data()
                            let messageId = queryDocumentSnapshot.documentID
                            let ownerId = data["ownerId"] as? String ?? ""
                            let conversationId = data["conversationId"] as? String ?? ""
                            let content = data["content"] as? String ?? ""
                            let timestamp = data["timestamp"] as? Date ?? Date()
                            print(content)
                            return Message(messageId: messageId, ownerId: ownerId, conversationId: conversationId, content: content, timestamp: timestamp)
                        }
                        print(self.messages)
                    }

                }
        
    }
    
    func loadChatList(){
        
        print("Start to load chat list")
            db.collection("conversations").getDocuments() { (querySnapshot, err) in
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
    
    func getConversations() -> [Conversation] {
        return self.conversations
    }
}
