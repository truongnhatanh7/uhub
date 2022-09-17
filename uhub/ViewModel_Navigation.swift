//
//  NavigationViewModel.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 02/09/2022.
//

import Foundation
import SwiftUI

enum Page {
    case Splash, SignIn, SignUp, EditProfile, FilterProfile, Security, Congrat, Setting, Account, Logout, Home, Detail, Matches, Chat, Inbox
}

final class PageViewModel: ObservableObject {
    @Published private(set) var currentPage: Page = .SignUp
    @Published var previousPage: Page? = nil
    @Published var isfirstFlow: Bool = false
    
    func visit(page: Page) {
        withAnimation {
            previousPage = currentPage
            currentPage = page
        }
    }
}
