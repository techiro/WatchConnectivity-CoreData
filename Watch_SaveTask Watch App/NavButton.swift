//
//  NavButton.swift
//  Watch_SaveTask Watch App
//
//  Created by TanakaHirokazu on 2022/09/26.
//

import SwiftUI


struct NavButton: View {
    var image: String
    var title: String
    var rect: CGRect
    var color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: image)
                .font(.title2)
                .frame(width: rect.width / 3, height: rect.width / 3, alignment: .center)
                .background(color)
                .clipShape(Circle())
            Text(title)
                .font(.system(size: 10))
                .foregroundColor(.white)
        }

    }
}

struct NavButton_Previews: PreviewProvider {
    static var previews: some View {
        NavButton(image: "star", title: "Rating", rect: CGRect(x: 100, y: 100, width: 100, height: 100), color: Color("orange"))
    }
}
