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
import SwiftUI

enum Page {
    case Splash, SignIn, SignUp, EditProfile, FilterProfile, Security, Congrat, Setting, Account, Logout, Home, Detail, Matches, Chat, Inbox, Notification
}

final class PageViewModel: ObservableObject {
    @Published private(set) var currentPage: Page = .Splash
    @Published var previousPage: Page? = nil
    @Published var isfirstFlow: Bool = false
    
    
    /// this function used to visit a page
    /// - Parameter page: page to visit
    func visit(page: Page) {
        withAnimation {
            previousPage = currentPage
            currentPage = page
        }
    }
}
