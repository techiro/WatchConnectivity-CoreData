//
//  SendToPhone.swift
//  Watch_SaveTask Watch App
//
//  Created by TanakaHirokazu on 2022/09/26.
//

import SwiftUI

struct SendToPhone: View {
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results: FetchedResults<Memo>
    @Environment(\.managedObjectContext) var moc

    var viewModel = SendMemoModel()

    var body: some View {
        Button {
            sendMessage()
        } label: {
             Text("Send to iPhone")
        }
    }

    func sendMessage() {
        let memos = getAllMemos()
        let jsonDecoder = JSONEncoder()

        do {
           let jsonData = try jsonDecoder.encode(memos)
            viewModel.session.sendMessageData(jsonData, replyHandler: nil) { data in
                
                print("send message data \(data)")
            }
        } catch (let err) {
            print("encode memos \(err)")
        }
    }

    func getAllMemos() -> [Memo] {
        let fetchRequest = Memo.fetchRequest()
        do {
            return try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies \(error)")
            return []
        }
    }
}

struct SendToPhone_Previews: PreviewProvider {
    static var previews: some View {
        SendToPhone()
    }
}
