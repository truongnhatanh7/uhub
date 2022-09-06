//
//  PickerInputModal.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 05/09/2022.
//

import SwiftUI

struct PickerInputModal: View {
    let label: String
    @Binding var showPicker: Bool
    @Binding var value: String
    let items: [String]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if showPicker {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundStyle(.black)
                    .opacity(0.4)
                    .onTapGesture {
                        withAnimation {
                            showPicker.toggle()
                        }
                    }
            }
            if showPicker {
                VStack {
                    HStack {
                        Text(label)
                            .font(.headline)
                        Spacer()
                        Button {
                            withAnimation {
                                showPicker.toggle()
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
                    Picker("", selection: $value) {
                        ForEach(items, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding([.top, .horizontal])
                .background(.background)
                .cornerRadius(20)
                .transition(.move(edge: .bottom))

            }
        }
        .ignoresSafeArea()
    }
}
