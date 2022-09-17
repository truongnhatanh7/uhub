/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Ho Le Minh Thach
 ID: s3877980
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class MatchEngine: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var matchesUsers : [User] = []
    @Published var currentUser: User?
    @Published var needReload: Bool = false
    @Published var showIsMatched: Bool = false
    
    private var fetchListnener: ListenerRegistration?
    
    deinit {
        fetchListnener?.remove()
    }
    
    
    /// Description This function used to check if a user is match with other
    /// - Parameters:
    ///   - user: <#user description#> user
    ///   - whenMatched: <#whenMatched description#> a callback
    ///   - whenNotMatched: <#whenNotMatched description#> a callback
    func isMatchWithOtherPerson(_ user: User, whenMatched: @escaping ()->Void, whenNotMatched: @escaping ()->Void) {
        if let currentUser = Auth.auth().currentUser {
            db.collection("matches").document(user.id).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    var likeUsers = data?["likes"] as? [[String: Any]] ?? [[:]]
                    
                    let targetIdx = likeUsers.firstIndex { element -> Bool in
                        element["id"] as? String ?? "" == currentUser.uid
                    }
                    
                    if let targetIdx = targetIdx {
                        likeUsers[targetIdx]["isMatched"] = true
                        self.db.collection("matches").document(user.id).setData([
                            "likes": likeUsers
                        ])
                        whenMatched()
                    } else {
                        whenNotMatched()
                    }
                } else {
                    print("Document does not exist")
                    whenNotMatched()
                }
            }
        }
    }
    
    
    /// <#Description#> This function create match pakage
    /// - Parameters:
    ///   - user: <#user description#> user
    ///   - isMatched: <#isMatched description#> boolean is match
    func createMatchPackage(_ user: User, isMatched: Bool) {
        if let currentUser = Auth.auth().currentUser {
            db.collection("matches").document(currentUser.uid).updateData([
                "likes": FieldValue.arrayUnion([
                    [
                        "id": user.id,
                        "fullname": user.name,
                        "age": user.age,
                        "school": user.school,
                        "major": user.major,
                        "gpa": user.gpa,
                        "semester_learned": user.semesterLearned,
                        "about": user.about,
                        "isMatched": isMatched
                    ]
                ])
            ]) { err in
                if let err = err {
                    print(err)
                    self.db.collection("matches").document(currentUser.uid).setData([
                        "likes": FieldValue.arrayUnion([
                            [
                                "id": user.id,
                                "fullname": user.name,
                                "age": user.age,
                                "school": user.school,
                                "major": user.major,
                                "gpa": user.gpa,
                                "semester_learned": user.semesterLearned,
                                "about": user.about,
                                "isMatched": isMatched
                            ]
                        ])
                    ])
                }
            }
        }
    }
    
    
    /// <#Description#> This function use to fetch all matches
    /// - Parameter callback: callback
    func fetchAllMatches(callback: @escaping ()->()) {
        if let currentUser = Auth.auth().currentUser {
            fetchListnener = db.collection("matches").document(currentUser.uid)
                .addSnapshotListener { (document, error) in
                    withAnimation {
                        if let document = document, document.exists {
                            let data = document.data()
                            var matchesUsers = data?["likes"] as? [[String: Any]] ?? [[:]]
                            matchesUsers = matchesUsers.filter { $0["isMatched"] as? Bool ?? false }
                            self.matchesUsers = matchesUsers.map { element -> User in
                                let id = element["id"] as? String ?? ""
                                let fullname = element["fullname"] as? String ?? ""
                                let age = element["age"] as? Int ?? 0
                                let school = element["school"] as? String ?? ""
                                let major = element["major"] as? String ?? ""
                                let gpa = element["gpa"] as? Int ?? 0
                                let semester_learned = element["semester_learned"] as? Int ?? 0
                                let about = element["about"] as? String ?? ""
                                return User(id: id, name: fullname, age: age, school: school, major: major, gpa: gpa, semesterLearned: semester_learned, about: about)
                            }
                            callback()
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
        }
    }
    
    
    /// <#Description#> This function is used to create dislike package
    /// - Parameter user: user
    func createDislikePackage(_ user: User) {
        if let currentUser = Auth.auth().currentUser {
            db.collection("matches").document(currentUser.uid).updateData([
                "dislikes": FieldValue.arrayUnion([user.id])
            ]) { err in
                if let err = err {
                    print(err)
                    self.db.collection("matches").document(currentUser.uid).setData([
                        "dislikes": FieldValue.arrayUnion([user.id])
                    ])
                }
            }
        }
    }
    
    
    /// This function used to remove match
    /// - Parameters:
    ///   - user: user
    ///   - userDevice: user device
    func removeMatch(user: User, userDevice: [String: Any]) {
        if let currentUser = Auth.auth().currentUser {
            db.collection("matches").document(currentUser.uid).updateData([
                "likes": FieldValue.arrayRemove([
                    [
                        "id": user.id,
                        "fullname": user.name,
                        "age": user.age,
                        "school": user.school,
                        "major": user.major,
                        "gpa": user.gpa,
                        "semester_learned": user.semesterLearned,
                        "about": user.about,
                        "isMatched": true
                    ]
                ])
            ]) { err in
                if let err = err {
                    print(err)
                }
            }
            
            db.collection("matches").document(user.id).updateData([
                "likes": FieldValue.arrayRemove([
                    [
                        "id": userDevice["id"],
                        "fullname": userDevice["fullname"],
                        "age": userDevice["age"],
                        "school": userDevice["school"],
                        "major": userDevice["major"],
                        "gpa": userDevice["gpa"],
                        "semester_learned": userDevice["semester_learned"],
                        "about": userDevice["about"],
                        "isMatched": true
                    ]
                ])
            ]) { err in
                if let err = err {
                    print(err)
                }
            }
        }
    }
}
