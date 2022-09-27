//
//  DeleteMemo.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/26.
//

import SwiftUI

struct DeleteMemo: View {
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results: FetchedResults<Memo>
    @State var deleteMemoItem: Memo?
    @State var deleteMemo = false

    @Environment(\.managedObjectContext) var context

    var body: some View {
        List(results) { item in
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 3, content: {
                    Text(item.title ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.white)

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
//        .listStyle(CarouselListStyle())
        .padding(.top)
        .overlay(
            Text(results.isEmpty ? "No Memo's found" : "")
        )
        .navigationTitle("Delete Memo")
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

    }

    func deleteMemo(memo: Memo) {
        context.delete(memo)
        do {
            try context.save()

        } catch {
            print("delete memo")
        }
    }
}

struct DeleteMemo_Previews: PreviewProvider {
    static var previews: some View {
        DeleteMemo()
    }
}
