//
//  Todo.swift
//  Todo
//
//  Created by dongnguyen on 28/8/24.
//

import Foundation
import SwiftData
import SwiftUI

typealias Todo = TodosSchemaV1.Todo

enum TodosSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Todo.self]
    }

    @Model
    class Todo {
        @Attribute(.unique) var id: UUID
        var title: String
        var isCompleted: Bool
        var dueDate: Date?

        init(title: String, isCompleted: Bool = false, dueDate: Date? = nil) {
            self.id = UUID()
            self.title = title
            self.isCompleted = isCompleted
            self.dueDate = dueDate
        }
    }
}

//enum TodosSchemaV2: VersionedSchema {
//    static var versionIdentifier = Schema.Version(2, 0, 0)
//    static var models: [any PersistentModel.Type] {
//        [Todo.self]
//    }
//
//    @Model
//    class Todo {
//        @Attribute(.unique) var id: UUID
//        var title: String
//        var isCompleted: Bool
//        var dueDate: Date?
//        var locked: Bool  // Đây là thuộc tính đơn
//
//        init(title: String, isCompleted: Bool = false, dueDate: Date? = nil, locked: Bool = false) {
//            self.id = UUID()
//            self.title = title
//            self.isCompleted = isCompleted
//            self.dueDate = dueDate
//            self.locked = locked
//        }
//    }
//}
//
//enum TodosMigrationPlan: SchemaMigrationPlan {
//    static var stages: [MigrationStage] {
//        [migrateV1toV2]
//    }
//
//    static var schemas: [any VersionedSchema.Type] {
//        [TodosSchemaV1.self, TodosSchemaV2.self]
//    }
//
//    static let migrateV1toV2 = MigrationStage.custom(
//        fromVersion: TodosSchemaV1.self,
//        toVersion: TodosSchemaV2.self,
//        willMigrate: { context in
//            let fetchRequest = FetchDescriptor<TodosSchemaV1.Todo>()
//            let todosV1 = try context.fetch(fetchRequest)
//            
//            // Duyệt qua tất cả các Todo từ V1 và tạo đối tượng V2 với giá trị locked mặc định là false
//            for todoV1 in todosV1 {
//                let todoV2 = TodosSchemaV2.Todo(
//                    title: todoV1.title,
//                    isCompleted: todoV1.isCompleted,
//                    dueDate: todoV1.dueDate,
//                    locked: false  // Thiết lập mặc định cho locked
//                )
//                
//                todoV2.id = todoV1.id  // Giữ nguyên ID từ phiên bản cũ
//                
//                context.insert(todoV2)
//            }
//        },
//        didMigrate: nil
//    )
//}
