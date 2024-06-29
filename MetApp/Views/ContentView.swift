//
//  ContentView.swift
//  MetApp
//
//  Created by Sravan Karuturi on 6/28/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        Text("Testing")
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
