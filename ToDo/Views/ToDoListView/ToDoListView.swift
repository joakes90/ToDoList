//
//  ContentView.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import SwiftUI

struct ToDoListView: View {

    @StateObject var viewModel = ToDoListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.toDoItems) { item in
                    HStack {
                        Text("\(item.name)")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .tint(.green)
                    }
                }
            }
            .navigationTitle("ToDos")
            .sheet(isPresented: $viewModel.shouldDisplaySheet,
                   onDismiss: {
                viewModel.refreshItems()
            }, content: {
                if let item = viewModel.displayItem {
                    ItemSheetView(viewModel: ItemSheetViewModel(toDoItem: item, shouldDisplaySheet: $viewModel.shouldDisplaySheet
                                        ))
                }
            })
            .toolbar {
                ToolbarItem {
                    Button(action: { viewModel.addButtonTapped() },
                           label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .overlay {
                if viewModel.toDoItems.isEmpty {
                    ContentUnavailableView("No ToDos just yet", systemImage: "list.bullet.rectangle.portrait")
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
}
