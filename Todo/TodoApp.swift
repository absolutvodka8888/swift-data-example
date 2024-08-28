//
//  TodoApp.swift
//  Todo
//
//  Created by dongnguyen on 28/8/24.
//

import SwiftData
import SwiftUI

@main
struct TodoApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(
                for: Todo.self, migrationPlan: TodosMigrationPlan.self
            )
        } catch {
            fatalError("Failed to initialize model container.")
        }
    }

//    init() {
//        do {
//            container = try ModelContainer(
//                for: Todo.self,
//                migrationPlan: TodosMigrationPlan.self
//            )
//        } catch {
//            fatalError("Failed to initialize model container.")
//        }
//    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
