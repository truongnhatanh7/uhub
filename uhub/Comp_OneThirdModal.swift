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

import SwiftUI

/// One Third Modal
struct OneThirdModal<T: View>: View {
    let label: String
    @Binding var showModal: Bool
    let content: () -> T
    
    init(label: String = "", showModal: Binding<Bool>, @ViewBuilder content: @escaping () -> T) {
        self.label = label
        self._showModal = showModal
        self.content = content
    }
    
    /// View body
    var body: some View {
        ZStack(alignment: .bottom) {
            if showModal {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundStyle(.black)
                    .opacity(0.4)
                    .onTapGesture {
                        withAnimation {
                            showModal.toggle()
                        }
                    }
            }
            
            if showModal {
                VStack {
                    HStack {
                        Text(label)
                            .font(.headline)
                        Spacer()
                        Button {
                            withAnimation {
                                showModal.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .padding(5)
                                .background(Color("pink_primary"))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }
                    content()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .modifier(OneThirdModalStyle())
            }
        }
        .ignoresSafeArea()
    }
}
