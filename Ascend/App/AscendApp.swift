//
//  AscendApp.swift
//  Ascend
//
//  Created by Vladimir Todorov on 30.04.26.
//

import SwiftUI
import SwiftData

@main
struct AscendApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ToDoTask.self)
    }
}
