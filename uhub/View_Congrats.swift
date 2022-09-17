/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 3
  Author: Nguyen Luu Quoc Bao
  ID: s3877698
  Created  date: 01/09/2022
  Last modified: 01/09/2022
  Acknowledgement: None
*/

import SwiftUI

struct CongratsView: View {
    
    @State private var isGoToHome = false
    @EnvironmentObject var pageVM: PageViewModel
    
    var body: some View {
        CongratsModal(isGoToHome: $isGoToHome)
            .onChange(of: isGoToHome) { newValue in
                if newValue {
                    pageVM.isfirstFlow = false
                    pageVM.visit(page: .Home)
                }
            }
    }
}
