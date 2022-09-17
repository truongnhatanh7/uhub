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

    var imageManager : ImageManager?
    var userAuthManager : UserAuthManager?
    var notificationManager : NotiManager?
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
                    let didNotify = data["didNotify"] as? Bool ?? false
                    let userNames = data["userNames"] as? [String: String] ?? [:]
                    let name = userNames[notThisUserId ?? ""]
                    
                    if Auth.auth().currentUser?.uid != latestMessageSender && unread && !didNotify { // Not the send + unread msg + did NOT notify -> play sound
                        if let isShowSound = (self.userAuthManager?.currentUserData["isShowSound"]) {
                            if isShowSound as! Bool {
            
                                playMusic(sound: "receive_message", isLoop: false)
                            }
                        }
                        
                        if let isShowChatNoti = (self.userAuthManager?.currentUserData["isShowChatNoti"]) {
                            if isShowChatNoti as! Bool {
                                self.notificationManager?.generateNoti(title: userNames[notThisUserId ?? ""] ?? "", subtitle: latestMessage)
                            }
                        }

                        self.db.collection("conversations").document(conversationId).updateData([ // Updatte latest message when sending new message from both sides
                            "didNotify": true
                        ])
                    }
                    
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
                    "latestMessageSender": currentUser.uid,
                    "didNotify": false
                ])
            }
            
            if let isShowSound = (userAuthManager?.currentUserData["isShowSound"]) {
                print("1 \(isShowSound)")
                if isShowSound as! Bool {
                    
                    playMusic(sound: "send_message", isLoop: false)
                }
                
            }

            
        }
    }
    
    func setRead() {
        print("Enter set read")
        if let currentConversation = currentConversation {
            db.collection("conversations").document(currentConversation.conversationId).getDocument {
                (document, err) in
                if let document = document, document.exists {
                    let data = document.data();
                    let unread = data?["unread"] as? Bool ?? false
                    let latestMessageSender = data?["latestMessageSender"] as? String ?? ""

                    if Auth.auth().currentUser?.uid != latestMessageSender && unread {
                        print("Trigger db modifying")
                        self.db.collection("conversations").document(currentConversation.conversationId).updateData([
                            "timestamp": Date(),
                            "unread": false,
                            "didNotify": true
                        ])
                    }
                } else {
                    print("Cannot set read message")
                }
            }

        }
    }
    
    func createConversation(recipientId: String, callback: @escaping (_ newConversationId : String, _ willFetch : Bool) -> ()) {
        var needToCreateNewInstance = true
        print("Check for already fetched conversations \(self.conversations)")
        for conversation in self.conversations { // Exist in local
            let notThisUserId = conversation.users.filter({ $0 != Auth.auth().currentUser?.uid }).first
            if (notThisUserId == recipientId) {
                print("Already fetched")
                self.currentConversation = conversation
                needToCreateNewInstance = false
                break;
            }
        }
        
        if needToCreateNewInstance { // create new in firebase
            db.collection("users").document(recipientId).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let fullname = data?["fullname"] as? String ?? ""
                    if let currentUser = Auth.auth().currentUser {
                        let docData: [String: Any] = [
                            "users": [currentUser.uid, recipientId],
                            "userNames": [currentUser.uid: self.userAuthManager?.currentUserData["fullname"] ?? "test",
                                              recipientId: fullname
                                         ]
                        ]
                        var ref: DocumentReference? = nil
                        ref = self.db.collection("conversations").addDocument(data: docData) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("Document added with ID: \(ref!.documentID)")
                                callback(ref!.documentID, true)
                            }
                        }
                        
                    }
                } else {
                    print("Document does not exist")
                }

            }
        } else {
            callback(self.currentConversation?.conversationId ?? "", false)
        }

    }
    
    func fetchConversationForCreation(toBeFetchedConversationId: String, callback: @escaping () -> ()) {
        
        db.collection("conversations").document(toBeFetchedConversationId).getDocument {
            (document, err) in
            if let document = document, document.exists {
                let data = document.data();
                let latestMessage = data?["latestMessage"] as? String ?? ""
                let timestamp = data?["timestamp"] as? Timestamp
                let unread = data?["unread"] as? Bool ?? false
                let users = data?["users"] as? [String] ?? []
                let latestMessageSender = data?["latestMessageSender"] as? String ?? ""
                let notThisUserId = users.filter({ $0 != Auth.auth().currentUser?.uid }).first
               // let didNotify = data?["didNotify"] as? Bool ?? false
                let userNames = data?["userNames"] as? [String: String] ?? [:]
                let name = userNames[notThisUserId ?? ""]
                
                self.currentConversation =  Conversation(conversationId: toBeFetchedConversationId, latestMessage: latestMessage, timestamp: timestamp?.dateValue() ?? Date(), unread: unread, users: users, userNames: userNames, latestMessageSender: latestMessageSender, name: name ?? "")
                callback()
            } else {
                
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
    
    func deleteConversationInDetailedView(id: String) {
        db.collection("conversations").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "").addSnapshotListener { (querySnapshot, err) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
            
                for doc in documents {
                    let data = doc.data()
                    let conversationId = doc.documentID
                    let users = data["users"] as? [String] ?? []
                    let notThisUserId = users.filter({ $0 != Auth.auth().currentUser?.uid }).first
                    if notThisUserId == id {
                        self.deleteConversation(id: conversationId)
                        break
                    }
                }
        }
    }
    
    func fetchUserImage(conversation: Conversation, callback: @escaping (_ img: UIImage) -> ()) {
        let notThisUserId = conversation.users.filter({ $0 != Auth.auth().currentUser?.uid }).first!
        if let val = imageManager?.memoizedImages[notThisUserId] {
            callback(val)
        } else {
            imageManager?.fetchFromUserId(id: notThisUserId) { img in
                callback(img)
            }
        }


    }
}
