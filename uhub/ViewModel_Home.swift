//
//  ViewModel_Home.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 09/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var fetchedUsers: [User] = []
    @Published var showDetailUser: Bool = false
    
    func fetchData(_ currentUserData: [String: Any], imageManager: ImageManager) {
        let db = Firestore.firestore()
        
        let usersRef = db.collection("users")
        
        let filter = currentUserData["friends_filter"] as? [String: Any]
        var minAge: Int = 18
        var maxAge: Int = .max
        switch AgeRange(type: filter?["friends_age"] as? Int ?? 0) {
        case .All:
            minAge = 18
            maxAge = .max
        case .From18To27:
            minAge = 18
            maxAge = 27
        case .From28To37:
            minAge = 28
            maxAge = 37
        case .From38To47:
            minAge = 38
            maxAge = 47
        case .From48To57:
            minAge = 48
            maxAge = 57
        case .GreaterThan57:
            minAge = 58
        }
        
        if let currentUser = Auth.auth().currentUser {
            usersRef
                .whereField("age", isGreaterThanOrEqualTo: minAge)
                .whereField("age", isLessThanOrEqualTo: maxAge)
                .limit(to: 50)
                .getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        db.collection("matches").document(currentUser.uid).getDocument { (document, error) in
                            withAnimation {
                                if let document = document, document.exists {
                                    let data = document.data()
                                    let dislikesUser = data?["dislikes"] as? [String] ?? [String]()
                                    
                                    for document in querySnapshot!.documents {
                                        let data = document.data()
                                        self.appendUser(data, filter, dislikesUser, currentUserData)
                                    }
                                } else {
                                    print("Document does not exist")
                                    for document in querySnapshot!.documents {
                                        let data = document.data()
                                        self.appendUser(data, filter, [String](), currentUserData)
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }
    
    func appendUser(_ data: [String: Any], _ filter: [String: Any]?, _ dislikesUser: [String], _ currentUserData: [String: Any]) {
        let id = data["id"] as? String
        let name = data["fullname"] as? String
        let age = data["age"] as? Int
        let school = data["school"] as? String
        let major = data["major"] as? String
        let gpa = data["gpa"] as? Int
        let semesterLearned = data["semester_learned"] as? Int
        let about = data["about"] as? String
        
        let user = User(id: id, name: name, age: age, school: school, major: major, gpa: gpa, semesterLearned: semesterLearned, about: about)
        print(dislikesUser.contains(where: {
            print("This is the id compare:", $0, user.id)
            return $0 == user.id
        }))
        if self.isUserMeetRequirement(
            user,
            GPAFilterRange(type: filter?["friends_gpa"] as? Int ?? 0),
            SemesterFilterRange(type: filter?["friends_semester_learned"] as? Int ?? 0)
        ) && user.id != currentUserData["id"] as? String && !dislikesUser.contains(where: { $0 == user.id }) {
            self.fetchedUsers.append(user)
        }
    }
    
    func getIdx(user: User) -> Int {
        fetchedUsers.firstIndex { $0.id == user.id } ?? 0
    }
    
    func removeUser(callbackWhenReachEmpty: @escaping () -> Void) {
        fetchedUsers.removeFirst()
        if fetchedUsers.isEmpty {
            callbackWhenReachEmpty()
        }
    }
    
    func isUserMeetRequirement(_ user: User, _ gpaFilter: GPAFilterRange, _ semesterFilter: SemesterFilterRange) -> Bool {
        print("\(gpaFilter.description) | \(semesterFilter.description)")
        print("gpa: \(user.gpa) | sem: \(user.semesterLearned)")
        var minSem = 0
        var maxSem = Int.max
        switch semesterFilter {
        case .All:
            minSem = 0
            maxSem = Int.max
        case .LessThan4:
            maxSem = 3
        case .From4To6:
            minSem = 4
            maxSem = 6
        case .From7To9:
            minSem = 7
            maxSem = 9
        case .From10To12:
            minSem = 10
            maxSem = 12
        case .GreaterThan12:
            minSem = 13
        }
        var semMatch = false
        if minSem <= user.semesterLearned && user.semesterLearned <= maxSem {
            semMatch = true
        }
        var gpaMatch = false
        if user.gpa == gpaFilter.rawValue || gpaFilter.rawValue == 0 {
            gpaMatch = true
        }
        print("gpa \(gpaMatch) | sem \(semMatch)")
        return semMatch && gpaMatch
    }
}
