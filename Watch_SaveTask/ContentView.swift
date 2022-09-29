//
//  ContentView.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results: FetchedResults<Memo>

    @Environment(\.managedObjectContext) var context

    @ObservedObject var viewModel = MessageListViewModel()
    @State private var isReachable = "NO"
    @State var memos: [Memo] = []
    @State var deleteMemoItem: Memo?
    @State var deleteMemo = false

    var body: some View {
        List {
            ForEach(memos, id: \.self ) { item in
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

                    Button(action: {
                        deleteMemoItem = item
                        deleteMemo = true
                    }, label: {
                        Image(systemName: "trash")
                            .font(.callout)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color("red"))
                            .cornerRadius(8)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .alert("次の動作を行いますか？", isPresented: $deleteMemo) {
            Button {
                print("Delete")
                deleteMemo(memo: deleteMemoItem!)
            } label: {
                Text("Delete")
                    .foregroundColor(.red)
            }
            Button {
                print("Cancel")
                deleteMemo.toggle()
            } label: {
                Text("Cancel")
            }
        }
        .onReceive(viewModel.$messagesData) { messages in
           if getAllMemos().isEmpty {
                messages.forEach { saveData(message: $0) }
                memos = getAllMemos()
                return
            }

//            // modifierされた場合
//            let containsMemo = messages.filter(containsMemoFilter)
//
//            for memo in containsMemo {
//                guard let watchMemo = messages.first(where: { $0.uuid == memo.uuid }) else { return }
//
////                memo.title = watchMemo.title
////                memo.dateAdded = watchMemo.dateAdded
//                do {
//
//                memo.setValue(watchMemo.title, forKey: "title")
//                memo.setValue(watchMemo.dateAdded, forKey: "dateAdded")
//
//                    try context.save()
//                    memos = getAllMemos()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }

            //new memo
            let notContainsMemo = messages.filter(notContainsMemoFilter)
            notContainsMemo.forEach {
                saveData(message: $0)
            }
            //deleteMemo
            updateMemos(watchMemos: messages)

            memos = getAllMemos()
        }
        .onAppear {
            print(getAllMemos().count)
             memos = getAllMemos()
//            deleteMemo()
        }
    }

    func rowRemove(offsets: IndexSet) {
        memos.remove(atOffsets: offsets)
    }

    func deleteMemo(memo: Memo) {
        context.delete(memo)
        do {
            try context.save()
            memos = getAllMemos()
        } catch {
            print("delete memo")
        }
    }

    func deleteAllMemo() {
        let fetchRequest = getAllMemos()

        for memo in fetchRequest {
            context.delete(memo)
            do {
                try context.save()
            } catch {
                print("error save()")
            }
        }
    }

    func saveData(message: Memo) {
        let newMemo = Memo(context: self.context)
        newMemo.uuid = message.uuid
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

    func getAllMemos(request: NSFetchRequest<Memo> = Memo.fetchRequest()) -> [Memo] {
        do {
            return try PersistenceController.shared.container.viewContext.fetch(request)
        } catch {
            print("Failed to fetch movies \(error)")
            return []
        }
    }
    func containsMemoFilter(memo: Memo) -> Bool {
        return memos.contains(where: { $0.uuid == memo.uuid })
    }
    func notContainsMemoFilter(memo: Memo) -> Bool {
        return !memos.contains(where: { $0.uuid == memo.uuid })
    }

    func updateMemos(watchMemos: [Memo]) {

        let fetchRequest = Memo.fetchRequest()
        let fetchData = try! context.fetch(fetchRequest)

        for memo in memos {
            if watchMemos.contains(where: {$0.uuid == memo.uuid}) {

                let updateMemo = watchMemos.first(where: { $0.uuid == memo.uuid })

                memo.title = updateMemo?.title
                memo.dateAdded = updateMemo?.dateAdded

                do {
                    try context.save()
                } catch {
                    print("error save updateMemos")
                }
            } else {
                deleteMemo(memo: memo)
            }
        }

//        for memo in memos {
//
//            if watchMemos.contains(where: {$0.uuid == memo.uuid}) {
//                print("exist: \(memo.title!)")
//
//            } else {
//                print("not exist: \(memo.title!)")
//                deleteMemo(memo: memo)
//            }
//        }

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
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
