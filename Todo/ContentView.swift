//
//  ContentView.swift
//  Todo
//
//  Created by dongnguyen on 28/8/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Todo.dueDate, order: .forward) private var todos: [Todo]
    
    @State private var newTodoTitle = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    HStack {
                        Text(todo.title)
                            .strikethrough(todo.isCompleted)
                        Spacer()
                        if let dueDate = todo.dueDate {
                            Text(dueDate, style: .date)
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                    }
                    .onTapGesture {
                        toggleComplete(todo)
                    }
                }
                .onDelete(perform: deleteTodos)
            }
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        TextField("New To-Do", text: $newTodoTitle)
                        Button("Add") {
                            addTodo()
                        }
                    }
                }
            }
        }
    }
    
    private func addTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = Todo(title: newTodoTitle)
        context.insert(newTodo)
        try? context.save()
        newTodoTitle = ""
    }
    
    private func toggleComplete(_ todo: Todo) {
        todo.isCompleted.toggle()
        try? context.save()
    }
    
    private func deleteTodos(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            context.delete(todo)
        }
        try? context.save()
    }
}
//
//#Preview {
//    ContentView()
//}
