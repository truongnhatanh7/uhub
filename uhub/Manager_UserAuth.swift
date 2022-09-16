//
//  UserAuthManager.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 03/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserAuthManager: ObservableObject {
    @Published var errorMsg: String = ""
    @Published var currentUserData: [String: Any] = [
        "id": "",
        "email": "",
        "password": "",
        "fullname": "",
        "age": 18,
        "school": "",
        "major": "",
        "gpa": 0,
        "semester_learned": 0,
        "about": "",
        "friends_filter": [
            "friends_age": 0,
            "friends_gpa": 0,
            "friends_semester_learned": 0
        ],
        "isActive": true,
        "timeLimit": 0.0
    ]
    
    private let db = Firestore.firestore()
    private var ref: DocumentReference? = nil
    
    func updateProfileInfo(updatedData: [String: Any], callback: @escaping () -> ()) {
        // update local user data
        self.currentUserData = self.currentUserData.merging(updatedData) { (_, new) in new }
        
        // find user document by user id
        db.collection("users")
            .document("\(self.currentUserData["id"]!)")
            .updateData(self.currentUserData) { error in
                if error != nil {
                    // update error msg
                    self.errorMsg = "[FAILURE - Update Profile Info]: \(error!.localizedDescription)"
                } else {
                    // update error msg
                    self.errorMsg = ""
                    
                    // success msg
                    print("[SUCCESS - Update Profile Info]: Updated User ID = \(self.currentUserData["id"]!)")
                }
                
                // execute callback function
                callback()
            }
    }
    
    func getUserById(id: String, callback: @escaping () -> ()) {
        db.collection("users").document("\(id)")
            .getDocument() { (document, error) in
                if let document = document, document.exists {
                    // update error msg
                    self.errorMsg = ""
                    
                    // data and its description
                    let data = document.data();
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    
                    // overwrting local user data
                    self.currentUserData = self.currentUserData.merging(data!) { (_, new) in new }
                    
                    // update active status
                    self.updateProfileInfo(updatedData: ["isActive": "true"], callback: {})
                    
                    // logs
                    print("[SUCCESS - Get User By Id]: Retrieved User Data = \(dataDescription)")
                    print("[LOGS - Current User]: \(self.currentUserData)")
                } else {
                    // update error msg
                    self.errorMsg = "[FAILURE - Get User By Id]: Cannot find User with id = \(id)"
                }
                
                // execute callback function
                callback()
            }
    }
    
    func createUser(inputData: [String: Any], callback: @escaping () -> ()) {
        // overwriting user data
        self.currentUserData = self.currentUserData.merging(inputData) { (_, new) in new }
        
        // set new document data as updated user data
        db.collection("users")
            .document("\(inputData["id"]!)")
            .setData(self.currentUserData) { error in
                if error != nil {
                    // update error msg
                    self.errorMsg = "[FAILURE - Create User]: \(error!.localizedDescription)"
                    
                } else {
                    // update error msg
                    self.errorMsg = ""
                    
                    // success msg
                    print("[SUCCESS - Create User]: User created with ID = \(String(describing: inputData["id"]!))")
                }
                
                // execute callback function
                callback()
            }
    }
    
    func signIn(inputEmail: String, inputPwd: String, callback: @escaping () -> (), firstTime: Bool) {
        Auth.auth().signIn(withEmail: inputEmail, password: inputPwd) { result, error in
            if error != nil {
                // update error msg
                self.errorMsg = "[FAILURE - SIGN IN]: \(error!.localizedDescription)"
                
                // execute callback function
                callback()
            } else {
                // update error msg
                self.errorMsg = ""
                
                // get logged in user id
                let userId = Auth.auth().currentUser?.uid
                
                // success msg
                print("[SUCCESS - SIGN IN]: Signed in \(inputEmail)")
                
                if let userId = userId {
                    // if first time log in, create new user on Firestore
                    // else, fetch user by signed in Auth id
                    if firstTime {
                        // create new user document
                        let newlyCreatedData: [String : Any] = [
                            "id": userId,
                            "email": inputEmail,
                            "password": inputPwd,
                            "isActive": true
                        ]
                        // create new user instance
                        self.createUser(inputData: newlyCreatedData, callback: callback)
                    } else {
                        // get exsisted user
                        self.getUserById(id: userId, callback: callback)
                    }
                }
            }
        }
    }
    
    func signUp(inputEmail: String, inputPwd: String, callback: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: inputEmail, password: inputPwd) { result, error in
            if error != nil {
                // update error msg
                self.errorMsg = "[FAILURE - SIGN UP]: \(error!.localizedDescription)"
                
                // execute callback function here, since callback will be passed to sign in if sign up succeeds
                callback()
            } else {
                // update error msg
                self.errorMsg = ""
                
                // success msg
                print("[SUCCESS - SIGN UP]: Signed up \(inputEmail)")
                
                // sign in Firebase Auth
                self.signIn(inputEmail: inputEmail, inputPwd: inputPwd, callback: callback, firstTime: true)
            }
        }
    }
    
    func signOut() {
        do {
            // sign out from Firebase Auth
            try Auth.auth().signOut()
            
            // update error msg
            self.errorMsg = ""
            
            // success msg
            print("[SUCCESS - SIGN OUT]: Signed out")
            
            // update active status
            self.updateProfileInfo(updatedData: ["isActive": false], callback: {})
            
            // reset currentUserData
            self.currentUserData = [
                "id": "",
                "email": "",
                "password": "",
                "fullname": "",
                "age": 18,
                "school": "",
                "major": "",
                "gpa": 0,
                "semester_learned": 0,
                "about": "",
                "friends_filter": [
                    "friends_age": 0,
                    "friends_gpa": 0,
                    "friends_semester_learned": 0
                ],
                "isActive": false,
                "timeLimit": 0.0
            ]
        } catch {
            // update error msg
            self.errorMsg = "[FAILURE - SIGN OUT]: \(error.localizedDescription)"
        }
    }
    
    func deleteAccount() {
        let user = Auth.auth().currentUser
        db.collection("users").document(user?.uid ?? "").delete() { error in
            if let error = error {
                print("Error clear user data: \(error)")
            } else {
                print("Successfully remove user data!")
            }
        }
        user?.delete() { error in
          if let error = error {
            // An error happened.
              print("Error removing document: \(error)")
          } else {
            // Account deleted.
              print("Remove account successfully!")
              
              // reset currentUserData
              self.currentUserData = [
                "id": "",
                "email": "",
                "password": "",
                "fullname": "",
                "age": 18,
                "school": "",
                "major": "",
                "gpa": 0,
                "semester_learned": 0,
                "about": "",
                "friends_filter": [
                    "friends_age": 0,
                    "friends_gpa": 0,
                    "friends_semester_learned": 0
                ],
                "isActive": false,
                "timeLimit": 0.0
              ]
          }
        }
    }
}
