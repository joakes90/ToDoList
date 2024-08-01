//
//  ToDoListViewModel.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import Foundation

final class ToDoListViewModel: ObservableObject {

    @Published var toDoItems = [ToDoItem]()
    @Published var shouldDisplaySheet = false
    var displayItem: ToDoItem?

    let persistenceDelegate: PersistenceDelegate

    init(persistenceDelegate: PersistenceDelegate = CoreDataStore.shared) {
        self.persistenceDelegate = persistenceDelegate
        refreshItems()
    }

    func refreshItems() {
        toDoItems = persistenceDelegate.fetchAllItems(of: .ToDoItem)
        .compactMap { $0 as? ToDoItemManagedObject }
        .map { $0.toDoItem }
        .sorted(by: { $0.createdDate < $1.createdDate })
    }

    func addButtonTapped() {
        displayItem = ToDoItem()
        shouldDisplaySheet = true
    }

    func toggleTaskCompletion(item: ToDoItem) {
        item.toggleComplete()
        refreshItems()
    }

    func renameItem(item: ToDoItem) {
        displayItem = item
        shouldDisplaySheet = true
    }

    func delete(itemAtIndextSet indexSet: IndexSet) {
        guard let index = indexSet.first else {
            refreshItems()
            return
        }
        let item = toDoItems[index]
        item.delete()
        toDoItems.remove(atOffsets: indexSet)
        refreshItems()
    }
}
