//
//  UserAuthManager.swift
//  uhub
//
//  Created by Andrew Le Nguyen on 03/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

struct CurrentUser: Codable, Identifiable {
    var id: String
    var email: String
    var password: String
    
    init (id: String, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}

class UserAuthManager: ObservableObject {
    @Published var isLoggedin: Bool = false
    @Published var errorMsg: String = ""
    @Published var currentUser: CurrentUser? = nil
    
    private let db = Firestore.firestore()
    private var ref: DocumentReference? = nil
    
    func updateCurrentUser(email: String, password: String) {
        db.collection("users").whereField("email", isEqualTo: email)
            .getDocuments() { (querySnapshot, error) in
                if error != nil {
                    // update error msg
                    self.errorMsg = "[FAILURE - Get User Id By Email]: \(error!.localizedDescription)"
                    
                } else {
//                    // update error msg
//                    self.errorMsg = ""
//
////                     success msg
//                    print("[SUCCESS - Get User Id By Email]: Retrieved User ID = \(querySnapshot!.documents[0].documentID)")
//
////                     update current user info
//                    self.currentUser = CurrentUser(
//                          id: querySnapshot!.documents[0].documentID,
//                          email: email,
//                          password: password
//                    )
//                    print("[LOGS - Current User]: \(self.currentUser!)")
                }
            }
    }
    
    func createUser(inputData: [String: Any]) {
        ref = db.collection("users").addDocument(data: inputData) { error in
            if error != nil {
                // update error msg
                self.errorMsg = "[FAILURE - Create User]: \(error!.localizedDescription)"
                
            } else {
                // update error msg
                self.errorMsg = ""
                
                // success msg
                print("[SUCCESS - Create User]: User created - User ID = \(self.ref!.documentID)")
                
                // update current user info
                self.currentUser = CurrentUser(
                      id: self.ref!.documentID,
                      email: String(describing: inputData["email"]!),
                      password: String(describing: inputData["password"]!)
                )
                print("[LOGS - Current User]: \(self.currentUser!)")
            }
        }
    }
    
    func signOut() {
        do {
            // sign out from Firebase Auth
            try Auth.auth().signOut()
            
            // success msg
            print("[SUCCESS - SIGN OUT]: Signed out")
            
            // update error msg
            self.errorMsg = ""
            
            // update login status msg, just to be sure
            self.isLoggedin = false
            
            // reset current user info
            self.currentUser = nil
            
        } catch {
            // update error msg
            self.errorMsg = "[FAILURE - SIGN OUT]: \(error.localizedDescription)"
            
            // update login status msg, just to be sure
            self.isLoggedin = true
        }
    }
    
    func signIn(inputEmail: String, inputPwd: String, callback: @escaping () -> ()) {
        Auth.auth().signIn(withEmail: inputEmail, password: inputPwd) { result, error in
            if error != nil {
                // update error msg
                self.errorMsg = "[FAILURE - SIGN IN]: \(error!.localizedDescription)"
                
                // update login status msg
                self.isLoggedin = false
                
            } else {
                // success msg
                print("[SUCCESS - SIGN IN]: Signed in \(inputEmail)")
                
                // update error msg
                self.errorMsg = ""
                
                // update login status msg
                self.isLoggedin = true
                
                // update current user
                self.updateCurrentUser(email: inputEmail, password: inputPwd)
            }
            
            // execute callback function
            callback()
        }
    }
    
    func signUp(inputEmail: String, inputPwd: String, callback: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: inputEmail, password: inputPwd) { result, error in
            if error != nil {
                // update error msg
                self.errorMsg = "[FAILURE - SIGN UP]: \(error!.localizedDescription)"
                
                // update login status msg, just to be sure
                self.isLoggedin = false
                
                // execute callback function here, since callback will be passed to sign in if sign up succeeds
                callback()
            } else {
                
                // update error msg
                self.errorMsg = ""
                
                // success msg
                print("[SUCCESS - SIGN UP]: Signed up \(inputEmail)")
                
                // sign in Firebase Auth
                self.signIn(inputEmail: inputEmail, inputPwd: inputPwd, callback: callback)
                
                // create new user document in Firebase Firestore
                self.createUser(inputData: ["email": inputEmail, "password": inputPwd])
            }
        }
    }
}
