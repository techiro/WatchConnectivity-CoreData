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

                        NavigationLink(destination: DeleteMemo()) {
                            NavButton(image: "trash", title: "delete", rect: rect, color: Color("red"))
                        }
                        .buttonStyle(PlainButtonStyle())

                    }
                    .frame(width: rect.width, alignment: .center)

                    HStack(spacing: 25) {
                        NavigationLink(destination: ViewMemo()) {
                            NavButton(image: "doc.plaintext", title: "Memo", rect: rect, color: Color("blue"))
                        }
                        .buttonStyle(PlainButtonStyle())


                        NavigationLink(destination:SendToPhone()) {
                            NavButton(image: "square.and.arrow.up", title: "Send to iPhone", rect: rect, color: Color("orange"))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(width: rect.width, alignment: .center)
                }

            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
