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
                        if item.isComplete {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        } else {
                            Image(systemName: "circle")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.toggleTaskCompletion(item: item)
                    }
                    .contextMenu(ContextMenu(menuItems: {
                        Button {
                            viewModel.renameItem(item: item)
                        } label: {
                            Text("Rename")
                        }

                    }))
                }
                .onDelete(perform: { indexSet in
                    viewModel.delete(itemAtIndextSet: indexSet)
                })
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
