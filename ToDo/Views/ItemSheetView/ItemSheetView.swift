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
                        viewModel.dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.saveToDoItem()
                    }
                }
            }
        }
        .interactiveDismissDisabled()
    }
}

#Preview {
    let mockTodo = ToDoItem(name: "no name", persistenceDelegate: nil)
    let viewModel = ItemSheetViewModel(toDoItem: mockTodo, shouldDisplaySheet: .constant(true))
    return ItemSheetView(viewModel: viewModel)
}
