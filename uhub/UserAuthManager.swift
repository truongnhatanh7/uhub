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
    @Published var response: String = "[DEFAULT]: User Auth Manager"
    
    private let db = Firestore.firestore()
    private var ref: DocumentReference? = nil
    
    func createUser(inputData: [String: Any]) {
        ref = db.collection("userProfiles")
            .addDocument(data: inputData) { error in
            if let error = error {
                print("[FAILURE]: Error adding document: \(error)")
            } else {
                print("[SUCCESS]: Document added with ID = \(self.ref!.documentID)")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.response = "[SUCCESS]: Sign Out"
            self.isLoggedin = false
        } catch {
            self.response = "[FAILURE]: Sign Out"
            print("[ERROR - SIGN OUT]: \(error.localizedDescription)")
        }
    }
    
    func signIn(inputEmail: String, inputPwd: String, callback: @escaping () -> ()) {
        Auth.auth().signIn(withEmail: inputEmail, password: inputPwd) { result, error in
            if error != nil {
                self.response = "[FAILURE]: Sign In"
                self.isLoggedin = false
                print("[ERROR - SIGN IN]: \(error!.localizedDescription)")
            } else {
                self.response = "[SUCCESS]: Sign In"
                self.isLoggedin = true
                callback()
            }
        }
    }
    
    func signUp(inputEmail: String, inputPwd: String, callback: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: inputEmail, password: inputPwd) { result, error in
            if error != nil {
                self.response = "[FAILURE]: Sign Up"
                print("[ERROR - SIGN UP]: \(error!.localizedDescription)")
            } else {
                self.response = "[SUCCESS]: Sign Up"
                self.signIn(inputEmail: inputEmail, inputPwd: inputPwd, callback: callback)
                self.createUser(inputData: ["email": inputEmail, "password": inputPwd])
            }
        }
    }
}
