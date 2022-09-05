//
//  ContentView.swift
//  uhub
//
//  Created by Truong Nhat Anh on 30/08/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var notificationSettings:NotificationSettings
    
    var body: some View {
        NotificationView().environmentObject(notificationSettings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
