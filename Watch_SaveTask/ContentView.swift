//
//  ContentView.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/25.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel = MessageListViewModel()
    @State private var isReachable = "NO"

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.isReachable = self.viewModel.session.isReachable ? "YES": "NO"
                    }) {
                        Text("Check")
                    }
                    .padding(.leading, 16.0)
                    Spacer()
                    Text("isReachable")
                        .font(.headline)
                        .padding()
                    Text(self.isReachable)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding()
                }
                .background(Color.init(.systemGray5))
                // 受信したメッセージを表示する
                List {
                    ForEach(self.viewModel.messagesData, id: \.self) { memo in

                        MessageRow(memo: memo)
                    }
                }
                .listStyle(PlainListStyle())
                Spacer()
            }
            .navigationTitle("Receiver")
        }
    }
}

struct MessageRow: View {
    let memo: Memo

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(memo.title!)
                    .font(.body)
                    .padding(.vertical, 4.0)
            }
            // 受信時のタイムスタンプ
            Text((memo.dateAdded?.formatted())!)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
