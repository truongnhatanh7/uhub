//
//  OneThirdModal.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 06/09/2022.
//

import SwiftUI

struct OneThirdModal<T: View>: View {
    let label: String
    @Binding var showModal: Bool
    let content: () -> T
    
    init(label: String = "", showModal: Binding<Bool>, @ViewBuilder content: @escaping () -> T) {
        self.label = label
        self._showModal = showModal
        self.content = content
    }
    
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
