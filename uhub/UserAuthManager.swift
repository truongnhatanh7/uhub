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
    @Published var isLoggedin: Bool = false
    @Published var errorMsg: String = ""
    
    private let db = Firestore.firestore()
    private var ref: DocumentReference? = nil
    
    func createUser(inputData: [String: Any]) {
        ref = db.collection("userProfiles").addDocument(data: inputData) { error in
            if error != nil {
                // update error msg
                self.errorMsg = "[FAILURE - Create User]: \(error!.localizedDescription)"
                
            } else {
                // update error msg
                self.errorMsg = ""
                
                // success msg
                print("[SUCCESS - Create User]: User created - User ID = \(self.ref!.documentID)")
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
