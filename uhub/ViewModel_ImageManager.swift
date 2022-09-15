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
    
    @Published var memoizedImages: [String: Image] = [:]
    
    func fetchAllImages(idList: [String]) {
        
    }
    
    func fetchFromUserId(id: String, callback: @escaping (_ image: Image) -> ()) {
        
    }
}
