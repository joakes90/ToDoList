//
//  ItemSheetView.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import SwiftUI

struct ItemSheetView: View {
    
    @ObservedObject var viewModel: ItemSheetViewModel

    var body: some View {
        NavigationView {
            Form {
                TextField("Item name", text: $viewModel.toDoItem.name)
            }
            .navigationTitle("Task")
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        print("canceling")
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        print("saveing")
                    }
                }
            }
        }
        .interactiveDismissDisabled()
    }
}

#Preview {
    let mockTodo = ToDoItem(name: "no name", persistenceDelegate: nil)
    let viewModel = ItemSheetViewModel(toDoItem: mockTodo)
    return ItemSheetView(viewModel: viewModel)
}
