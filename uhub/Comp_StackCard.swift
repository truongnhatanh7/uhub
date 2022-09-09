//
//  StackCard.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 09/09/2022.
//

import SwiftUI

struct StackCard: View {
    @EnvironmentObject var homeVM: HomeViewModel
    var user: User
    
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    
    @State var btnSwipe = false
    @State var opacity: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            let idx = CGFloat(homeVM.getIdx(user: user))
            let topOffset = (idx <= 2 ? idx : 2) * 15
            
            ZStack {
                Image(user.profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(15)
                    .offset(y: -topOffset)
                    .overlay(alignment: .top) {
                        Text("Like")
                            .font(.title.bold())
                            .foregroundColor(Color("pink_primary"))
                            .padding(10)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("pink_primary"), lineWidth: 4))
                            .opacity(btnSwipe ? opacity / 100.0 : offset / 100.0)
                            .rotationEffect(Angle(degrees: -30))
                            .offset(x: -100, y: 50)
                        
                        Text("Nope")
                            .font(.title.bold())
                            .foregroundColor(Color("pink_primary"))
                            .padding(10)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("pink_primary"), lineWidth: 4))
                            .opacity(btnSwipe ? opacity / -100.0 : offset / -100.0)
                            .rotationEffect(Angle(degrees: 30))
                            .offset(x: 100, y: 50)
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 20)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
            DragGesture()
                .updating($isDragging) { value, out, _ in
                    out = true
                }
                .onChanged { value in
                    let translation = value.translation.width
                    offset = isDragging ? translation : .zero
                }
                .onEnded { value in
                    let width = getRect().width - 50
                    let translation = value.translation.width
                    let checkingStatus = translation > 0 ? translation : -translation
                    
                    withAnimation {
                        if checkingStatus > width / 2 {
                            offset = (translation > 0 ? width : -width) * 2
                            endSwipeAction()
                            
                            if translation > 0 {
                                rightSwipe()
                            } else {
                                leftSwipe()
                            }
                        } else {
                            offset = .zero
                        }
                    }
                }
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
            guard let info = data.userInfo else { return }
            let id = info["id"] as? String ?? ""
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = getRect().width - 50
            if user.id == id {
                withAnimation {
                    opacity = rightSwipe ? 100 : -100
                    btnSwipe = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        offset = (rightSwipe ? width : -width) * 2
                        endSwipeAction()
                        
                        if rightSwipe {
                            self.rightSwipe()
                        } else {
                            leftSwipe()
                        }
                    }
                }
            }
        }
    }
    
    func getRotation(angle: Double) -> Double {
        let rotation = (offset / (getRect().width - 50)) * angle
        return rotation
    }
    
    func endSwipeAction() {
        withAnimation { endSwipe = true }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            if let _ = homeVM.displayingUsers?.first {
                let _ = withAnimation {
                    homeVM.displayingUsers?.removeFirst()
                }
            }
        }
    }
    
    func leftSwipe() {
        
    }
    
    func rightSwipe() {
        
    }
}

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
