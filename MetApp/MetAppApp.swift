//
//  MetAppApp.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/28/24.
//

import SwiftUI
import SwiftData

@main
struct MetAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MetalView()
        }
        .modelContainer(sharedModelContainer)
    }
}
