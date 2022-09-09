//
//  NavigationViewModel.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 02/09/2022.
//

import Foundation
import SwiftUI

enum Page {
    case Splash, SignIn, SignUp, EditProfile, FilterProfile, Notification, Security, Congrat, Setting, Logout, Home, Detail, Matches, Chat, Inbox
}

final class PageViewModel: ObservableObject {
    @Published private(set) var currentPage: Page = .SignIn
    
    func visit(page: Page) {
        withAnimation {
            currentPage = page
        }
    }
}
