/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Authors:
 + S3877980 - Ho Le Minh Thach
 + S3878231 - Truong Nhat Anh
 + S3877698 - Nguyen Luu Quoc Bao
 + S3820098  - Le Nguyen Truong An
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgements: Learning from Hacking with Swift to implement MVVM, and the usage of CoreData
 Hudson, P. (n.d.). The 100 days of Swiftui. Hacking with Swift. Retrieved July 30, 2022, from https://www.hackingwithswift.com/100/swiftui
*/

import Foundation
import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        // provide only images
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        // make sure that coordinator will be delegate to the picker
        // this mean if there is any event -> tell coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    /// ImagePicker will have a coordinator to handle communcation between itself and PHPickerViewController
    /// - Returns: Coordinator instance that control the PHPickerViewController
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// NSObject make sure that Obj-C can communicate with the Coordinator at runtime
    /// PHPicherViewControllerDelegate adds functionality for detecting when the user selects an image
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        /// Tell the coordinator object that its parent is image picker
        /// - Parameter parent: ImagePicker instance is its parent
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        /// This function will run when the user finished their selection
        /// - Parameters:
        ///   - picker: The controller of image picker
        ///   - results: The assets that user selected
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // dismiss the sheet
            picker.dismiss(animated: true)
            
            // exist if no selection from user
            guard let provider = results.first?.itemProvider else { return }
            
            // if there is images try to load it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    // go to the image picker and set the image
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}
