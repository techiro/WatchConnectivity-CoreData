//
//  Watch_SaveTaskApp.swift
//  Watch_SaveTask
//
//  Created by TanakaHirokazu on 2022/09/25.
//

import SwiftUI

@main
struct Watch_SaveTaskApp: App {
    let container = PersistenceReceiver.shared.container

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environment(\.managedObjectContext, container.viewContext)
        }
    }
}
