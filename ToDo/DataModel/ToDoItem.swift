//
//  ToDoItem.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import Foundation

struct ToDoItem: Identifiable {
    
    private var managedObject: ToDoItemManagedObject
    private var persistenceDelegate: PersistenceDelegate?

    var id: UUID {
        managedObject.id ?? UUID()
    }

    var name: String {
        get { managedObject.name ?? "Unnamed" }
        set { managedObject.name = newValue }
    }
    
    var isComplete: Bool {
        get { managedObject.isComplete }
        set { managedObject.isComplete = newValue }
    }
    
    var createdDate: Date {
        managedObject.createdDate ?? Date()
    }
    
    init(managedObject: ToDoItemManagedObject, persistenceDelegate: PersistenceDelegate? = CoreDataStore.shared) {
        self.managedObject = managedObject
        self.persistenceDelegate = persistenceDelegate
    }
    
    init(name: String = "Unnamed", persistenceDelegate: PersistenceDelegate? = CoreDataStore.shared) {
        self.persistenceDelegate = persistenceDelegate
        self.managedObject = persistenceDelegate?.createManagedObject(for: .ToDoItem) as! ToDoItemManagedObject
        self.managedObject.name = name
        self.managedObject.createdDate = Date()
        self.managedObject.isComplete = false
    }
    
    func save() {
        persistenceDelegate?.save()
    }
    
    func delete() throws {
        try persistenceDelegate?.delete(item: managedObject)
    }
    
    static func fetchAll(persistenceDelegate: PersistenceDelegate = CoreDataStore.shared) -> [ToDoItem] {
        let managedObjects = persistenceDelegate.fetchAllItems(of: .ToDoItem) as! [ToDoItemManagedObject]
        return managedObjects.map { ToDoItem(managedObject: $0, persistenceDelegate: persistenceDelegate) }
    }
}
