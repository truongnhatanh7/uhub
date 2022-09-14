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
import FirebaseStorage

class ChatEngine: ObservableObject {
    private let db = Firestore.firestore()

    @StateObject var userAuthManager = UserAuthManager()
    @Published var messages: [Message] = []
    @Published var conversations: [Conversation] = []
    @Published var currentConversation: Conversation?
    @Published var isProcessing: Bool = false
    @Published var lastMessageId: String = ""
    @Published var conversationStatus: [String: Bool] = [:]
    @Published var imagesMemoization: [String: UIImage] = [:]
    
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
                 print("[Firebase triggers new messages]")
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
                        if self.lastMessageId != latestMsg.id {
                            self.lastMessageId = latestMsg.id
                        }
                        
                    }
                }
            }
         }
         
    }
    
    func loadChatList(callback: @escaping ()->()) {
        print("Start to load chat list") // TODO: Load chat that belongs to that user (save in user db)
        conversationListener = db.collection("conversations").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "").addSnapshotListener { (querySnapshot, err) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
            
            DispatchQueue.main.async {
                self.conversations = documents.map { (queryDocumentSnapshot) -> Conversation in
                    let data = queryDocumentSnapshot.data()
                    let conversationId = queryDocumentSnapshot.documentID
                    let latestMessage = data["latestMessage"] as? String ?? ""
                    let timestamp = data["timestamp"] as? Timestamp
                    let unread = data["unread"] as? Bool ?? false
                    let users = data["users"] as? [String] ?? []
                    let latestMessageSender = data["latestMessageSender"] as? String ?? ""
                    let notThisUserId = users.filter({ $0 != Auth.auth().currentUser?.uid }).first
                    let userNames = data["userNames"] as? [String: String] ?? [:]
                    let name = userNames[notThisUserId ?? ""]
                    
                    return Conversation(conversationId: conversationId, latestMessage: latestMessage, timestamp: timestamp?.dateValue() ?? Date(), unread: unread, users: users, userNames: userNames, latestMessageSender: latestMessageSender, name: name ?? "")
                }
                
                self.conversations.sort { $0.timestamp > $1.timestamp }
                callback()
                self.objectWillChange.send()
            }
        }
    }
    
    func sendMessage(content: String) {
        if content == "" { return }
        
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
            
            playMusic(sound: "send_message", isLoop: false)
            
        }
    }
    
    func setRead() {
        if let currentConversation = currentConversation {
            if Auth.auth().currentUser?.uid != currentConversation.latestMessageSender && currentConversation.unread { // If unread == false, do not call this
                db.collection("conversations").document(currentConversation.conversationId).updateData([
                    "timestamp": Date(),
                    "unread": false
                ])
            }
        }
    }
    
    func createConversation(recipientId: String, callback: @escaping () -> ()) {
        // lay current user + fetch user recipient -> conversation
        db.collection("users").document(recipientId).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let fullname = data?["fullname"] as? String ?? ""
                // TODO: take avatar
                if let currentUser = Auth.auth().currentUser {
                    let docData: [String: Any] = [
                        "users": [currentUser.uid, recipientId],
                        "userNames": [currentUser.uid: self.userAuthManager.currentUserData["fullname"],
                                          recipientId: fullname
                                     ]
                    ]
                    
                    self.db.collection("conversations").addDocument(data: docData)
                    callback()
                }
            } else {
                print("Document does not exist")
            }

        }
    }
    
    func fetchUserStatus() {
        for conversation in conversations {
            let notThisUserId = conversation.users.filter({ $0 != Auth.auth().currentUser?.uid }).first!
            db.collection("users").document(notThisUserId).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let status = data?["isActive"] as? Bool ?? false
                    self.conversationStatus[notThisUserId] = status
                    print(self.conversationStatus)
                    self.objectWillChange.send()
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func deleteConversation(id: String) {
        db.collection("conversations").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func fetchUserImage(conversation: Conversation, callback: @escaping (_ img: UIImage) -> ()) {

        let notThisUserId = conversation.users.filter({ $0 != Auth.auth().currentUser?.uid }).first!
        if let val = imagesMemoization[notThisUserId] {
            callback(val)
        } else {
            let storage = Storage.storage().reference()
            let ref = storage.child("images/\(notThisUserId).jpg")
            ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                // Uh-oh, an error occurred!
                  print(error)
              } else {
                  print("Retrived image")
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                  self.imagesMemoization[notThisUserId] = image
                  callback(image!)
              }
            }
        }


    }
}
