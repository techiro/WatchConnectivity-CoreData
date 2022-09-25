//
//  ViewModel.swift
//  Watch_SaveTask Watch App
//
//  Created by TanakaHirokazu on 2022/09/25.
//

import SwiftUI
import CoreData

struct ViewMemo: View {
    
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results: FetchedResults<Memo>

    var body: some View {
        List(results) { item in
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
        }
        .listStyle(CarouselListStyle())
        .padding(.top)
        .overlay(
            Text(results.isEmpty ? "No Memo's found" : "")
        )
        .navigationTitle("Memo's")

    }
}

struct ViewMemo_Previews: PreviewProvider {
    static var previews: some View {
        ViewMemo()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
