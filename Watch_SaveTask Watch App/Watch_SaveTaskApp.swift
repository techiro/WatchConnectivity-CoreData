//
//  Watch_SaveTaskApp.swift
//  Watch_SaveTask Watch App
//
//  Created by TanakaHirokazu on 2022/09/25.
//

import SwiftUI

@main
struct Watch_SaveTask_Watch_AppApp: App {
    let container = PersistenceController.shared.container
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, container.viewContext)
            }
        }
    }
}
