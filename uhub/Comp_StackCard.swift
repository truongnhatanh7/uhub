//
//  StackCard.swift
//  uhub
//
//  Created by Ho Le Minh Thach on 09/09/2022.
//

import SwiftUI

struct StackCard: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var userAuthManager: UserAuthManager
    @EnvironmentObject var matchEngine: MatchEngine
    
    var user: User
    
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    
    @State var btnSwipe = false
    @State var opacity: CGFloat = 0
    @State var startYPosition: CGFloat = 0
    @State var showDetailUser = false
    @State var showIsMatchUser = false
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let size = proxy.size
                let idx = CGFloat(homeVM.getIdx(user: user))
                let topOffset = (idx <= 2 ? idx : 2) * 15
                ZStack {
                    Card(width: size.width - topOffset, height: size.height, imageURL: user.id)
                        .offset(y: -topOffset)
                        .overlay(alignment: .bottom) {
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack(alignment: .firstTextBaseline) {
                                        Text("\(user.name)")
                                            .font(.largeTitle)
                                        Text("\(user.age)")
                                            .font(.title2)
                                    }
                                    Label("\(user.school)", systemImage: "graduationcap.fill")
                                        .font(.title3)
                                }
                                Spacer()
                                Button {
                                    showDetailUser = true
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.title)
                                }
                            }
                            .padding(.bottom, 40)
                            .padding(.horizontal, 20)
                            .foregroundColor(.white)
                        }
                        .overlay(alignment: .top) {
                            Text("Like")
                                .font(.title.bold())
                                .foregroundStyle(.ultraThickMaterial)
                                .padding(10)
                                .background(Color("green"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .opacity(btnSwipe ? opacity / 100.0 : offsetX / 100.0)
                                .rotationEffect(Angle(degrees: -30))
                                .offset(x: -100, y: 50)
                            
                            Text("Nope")
                                .font(.title.bold())
                                .foregroundStyle(.ultraThickMaterial)
                                .padding(10)
                                .background(Color("red_danger"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .opacity(btnSwipe ? opacity / -100.0 : offsetX / -100.0)
                                .rotationEffect(Angle(degrees: 30))
                                .offset(x: 100, y: 50)
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .offset(x: offsetX, y: offsetY)
            .rotationEffect(.init(degrees: getRotation(angle: 20)))
            .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
            .gesture(
                DragGesture()
                    .updating($isDragging) { value, out, _ in
                        out = true
                    }
                    .onChanged { value in
                        withAnimation(.linear(duration: 0.1)) {
                            let startYPosition = value.startLocation.y
                            self.startYPosition = isDragging ? startYPosition : .zero
                            let translationX = value.translation.width
                            offsetX = isDragging ? translationX : .zero
                            let translationY = value.translation.height
                            offsetY = isDragging ? translationY : .zero
                        }
                    }
                    .onEnded { value in
                        let width = getRect().width - 100
                        let translationX = value.translation.width
                        let checkingStatusX = translationX > 0 ? translationX : -translationX
                        withAnimation {
                            if checkingStatusX > width / 2 {
                                offsetX = (translationX > 0 ? width + 80 : -width - 80) * 2
                                if translationX > 0 {
                                    rightSwipe()
                                } else {
                                    leftSwipe()
                                }
                            } else {
                                offsetX = .zero
                                offsetY = .zero
                                startYPosition = .zero
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
                            offsetX = (rightSwipe ? width : -width) * 2
                            offsetY = .zero
                            startYPosition = .zero
                            
                            if rightSwipe {
                                self.rightSwipe()
                            } else {
                                leftSwipe()
                            }
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showDetailUser) {
                View_UserDetail(isShowSheet: $showDetailUser, isFromMatchPage: false, user: user)
            }
            .fullScreenCover(isPresented: $showIsMatchUser) {
                MatchCongrat(showIsMatchUser: $showIsMatchUser, userId: user.id)
            }
            .onChange(of: showIsMatchUser) { newValue in
                if !newValue {
                    endSwipeAction()
                }
            }
        }
    }
    
    func getRotation(angle: Double) -> Double {
        let rotation = (offsetX / (getRect().width - 50)) * angle * (startYPosition > 250 ? -1 : 1)
        return rotation
    }
    
    func endSwipeAction() {
        withAnimation { endSwipe = true }
        if !showIsMatchUser {
            print("This is match user", showIsMatchUser)
            print("Remove card")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                if let _ = homeVM.fetchedUsers.first {
                    let _ = withAnimation {
                        homeVM.removeUser {}
                    }
                }
            }
        }
    }
    
    func leftSwipe() {
        matchEngine.createDislikePackage(user)
        endSwipeAction()
    }
    
    func rightSwipe() {
        matchEngine.isMatchWithOtherPerson(user) {
            showIsMatchUser = true
            matchEngine.createMatchPackage(user, isMatched: true)
        } whenNotMatched: {
            matchEngine.createMatchPackage(user, isMatched: false)
            endSwipeAction()
        }
    }
}

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
