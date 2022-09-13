//
//  Comp_FirebaseImage.swift
//  uhub
//
//  Created by Truong Nhat Anh on 13/09/2022.
//

import SwiftUI

let placeholder = UIImage(named: "placeholder_avatar.png")!

struct FirebaseImage : View {

    init(id: String) {
        self.imageLoader = Loader(id)
    }

    private var imageLoader : Loader

    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }

    var body: some View {
        Image(uiImage: image ?? placeholder)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(Circle())

    }
}

//struct Comp_FirebaseImage_Previews: PreviewProvider {
//    static var previews: some View {
//        FirebaseImage()
//    }
//}
