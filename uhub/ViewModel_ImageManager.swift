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
import FirebaseStorage
import SwiftUI

class ImageManager: ObservableObject {
    
    @Published var memoizedImages: [String: UIImage] = [:]
    
    func fetchAllImages(idList: [String]) {
        
    }
    
    
    /// This function used to fetch user by id
    /// - Parameters:
    ///   - id: id
    ///   - callback: callback
    func fetchFromUserId(id: String, callback: @escaping (_ img: UIImage) -> ()) {
        if let val = memoizedImages[id] {
            callback(val)
        } else {
            callback(UIImage(imageLiteralResourceName: "placeholder_avatar"))
            //            let storage = Storage.storage().reference()
            //            let ref = storage.child("images/\(id).jpg")
            //            ref.getData(maxSize: 1 * 2140 * 2140) { data, error in
            //              if let error = error {
            //                  print(error)
            //                  callback(UIImage(imageLiteralResourceName: "placeholder_avatar"))
            //              } else {
            //                  print("Retrived image")
            //                let image = UIImage(data: data!)
            //                  self.memoizedImages[id] = image
            //                  callback(image!)
            //              }
            //            }
        }
    }
}
