//
//  SwiftUi_RealtimeChatAppApp.swift
//  SwiftUi-RealtimeChatApp
//
//  Created by Zahra chouchane on 7/12/2022.
//

import SwiftUI

@main
struct SwiftUi_RealtimeChatAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
