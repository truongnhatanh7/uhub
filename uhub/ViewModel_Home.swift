//
//  ViewModel_Home.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 09/09/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var fetchedUsers: [User] = []
    @Published var displayingUsers: [User]?
    
    init() {
        fetchedUsers = [
//            User(name: "Michael", place: "Vietnam", profilePic: "User1"),
//            User(name: "Andrew", place: "Singapore", profilePic: "User2"),
//            User(name: "Anh", place: "Thailand", profilePic: "User3"),
//            User(name: "Bao", place: "USA", profilePic: "User4"),
//            User(name: "John", place: "Malay", profilePic: "User5"),
//            User(name: "Henry", place: "Australia", profilePic: "User6"),
//            User(name: "Mary", place: "Hongkong", profilePic: "User7"),
//            User(name: "Annie", place: "England", profilePic: "User8"),
//            User(name: "Tom", place: "Russia", profilePic: "User9"),
//            User(name: "Water", place: "Japan", profilePic: "User10")
//            
        ]
        displayingUsers = fetchedUsers
    }
    
    func getIdx(user: User) -> Int {
        displayingUsers?.firstIndex { $0.id == user.id } ?? 0
    }
}

//struct User: Identifiable {
//    var id = UUID().uuidString
//    var name: String
//    var place: String
//    var profilePic: String
//}
