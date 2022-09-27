//
//  SendToPhone.swift
//  Watch_SaveTask Watch App
//
//  Created by TanakaHirokazu on 2022/09/26.
//

import SwiftUI

struct SendToPhone: View {
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results: FetchedResults<Memo>

    var viewModel = SendMemoModel()

    var body: some View {
        Button {
            sendMessage()
        } label: {
             Text("Send to iPhone")
        }
    }

    func sendMessage() {
        for result in results {
            let messages: [String: Any] =
            ["title": result.title!,
             "dateAdded": result.dateAdded!]
            viewModel.session.sendMessage(messages, replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
        }
    }

}

struct SendToPhone_Previews: PreviewProvider {
    static var previews: some View {
        SendToPhone()
    }
}
