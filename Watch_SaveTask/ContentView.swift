//
//  ContentView.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/25.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results: FetchedResults<Memo>

    @Environment(\.managedObjectContext) var context

    @ObservedObject var viewModel = MessageListViewModel()
    @State private var isReachable = "NO"
    
    var body: some View {
        List(viewModel.messagesData) { item in
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 3, content: {
                    Text(item.title ?? "")
                        .font(.system(size: 12))

                    HStack {
                        Text("Last Modified")
                            .font(.system(size: 8))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)

                        Text(item.dateAdded ?? Date(), style: .date)
                            .font(.system(size: 8))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                })

                Spacer(minLength: 4)


            }
        }
        .onReceive(viewModel.$messagesData) { messages in
            messages.forEach {saveData(message: $0)}
        }
        .onAppear {
            viewModel.messagesData = getAllMemos()
        }
    }

    func saveData(message: Memo) {
        let newMemo = Memo(context: self.context)

        newMemo.title = message.title
        newMemo.dateAdded = message.dateAdded

        do {
            if context.hasChanges {
                try self.context.save()
            }
        } catch (let err) {
            print("Cannot save newMemo:\(err.localizedDescription)")
        }

    }

    func getAllMemos() -> [Memo] {
        let fetchRequest = Memo.fetchRequest()
        do {
            return try PersistenceReceiver.shared.container.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies \(error)")
            return []
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
            .environment(\.managedObjectContext, PersistenceReceiver.preview.container.viewContext)
    }
}
