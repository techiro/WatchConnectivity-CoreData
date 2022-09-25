//
//  ContentView.swift
//  Watch_SaveTask Watch App
//
//  Created by TanakaHirokazu on 2022/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            GeometryReader { reader in
                let rect = reader.frame(in: .global)
                VStack(spacing: 15) {
                    HStack(spacing: 25) {
                        NavigationLink(
                            destination: AddItem(),
                            label: {
                                NavButton(image: "plus",
                                          title: "Memo", rect: rect,
                                          color: Color("pink"))
                            })
                        .buttonStyle(PlainButtonStyle())

                        NavButton(image: "trash", title: "delete", rect: rect, color: Color("red"))
                    }
                    .frame(width: rect.width, alignment: .center)

                    HStack(spacing: 25) {
                        NavigationLink(destination: ViewMemo()) {
                            NavButton(image: "doc.plaintext", title: "Memo", rect: rect, color: Color("pink"))
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavButton(image: "trash", title: "delete", rect: rect, color: Color("red"))
                    }
                    .frame(width: rect.width, alignment: .center)
                }

            }
    }
}


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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
