//
//  ToDoListViewModel.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import Foundation

final class ToDoListViewModel: ObservableObject {
    
    @Published var toDoItems = [ToDoItem]()
    @Published var displayItem: ToDoItem?
    @Published var sheet = false
    
    let persistenceDelegate: PersistenceDelegate
    
    init(persistenceDelegate: PersistenceDelegate = CoreDataStore.shared) {
        self.persistenceDelegate = persistenceDelegate
    }
    
    func addButtonTapped() {
        displayItem = ToDoItem()
    }
}
