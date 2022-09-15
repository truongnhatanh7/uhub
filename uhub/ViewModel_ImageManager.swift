//
//  ViewModel_ImageManager.swift
//  uhub
//
//  Created by Truong Nhat Anh on 15/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class ImageManager: ObservableObject {
    
    @Published var memoizedImages: [String: UIImage] = [:]
    
    func fetchAllImages(idList: [String]) {
        
    }
    
    func fetchMatchesImages(users: [User]) {

    }
    
    func fetchFromUserId(id: String, callback: @escaping (_ img: UIImage) -> ()) {
        if let val = memoizedImages[id] {
            callback(val)
        } else {
            let storage = Storage.storage().reference()
            let ref = storage.child("images/\(id).jpg")
            ref.getData(maxSize: 1 * 2140 * 2140) { data, error in
              if let error = error {
                  print(error)
              } else {
                  print("Retrived image")
                let image = UIImage(data: data!)
                  self.memoizedImages[id] = image
                  callback(image!)
              }
            }
        }
    }
}
