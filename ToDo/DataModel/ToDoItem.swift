//
//  ToDoItem.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import Foundation

struct ToDoItem: ManagedObjectRepresentable {
    
    var managedObject: ToDoItemManagedObject
    var persistanceDelegate: any PersistanceDelegate

    var name: String
    var isComplete: Bool
    let createdDate: Date
    
    init(managedObject: ToDoItemManagedObject,
         persistanceDelegate: PersistanceDelegate = CoreDataStore.shared) {
        self.managedObject = managedObject
        self.persistanceDelegate = persistanceDelegate
        self.name = managedObject.name ?? "Unnamed"
        self.isComplete = managedObject.isComplete
        self.createdDate = managedObject.createdDate ?? Date()
    }
    
    init(name: String,
         persistanceDelegate: PersistanceDelegate = CoreDataStore.shared) {
        self.name = name
        self.createdDate = Date()
        self.isComplete = false
        self.managedObject = persistanceDelegate.createManagedObject(type: .ToDoItem) as! ToDoItemManagedObject
        self.persistanceDelegate = persistanceDelegate
    }
    
    func update() throws {
        managedObject.isComplete = isComplete
        managedObject.name = name
        try persistanceDelegate.save()
    }
    
    func delete() throws {
        try persistanceDelegate.delete(item: managedObject)
    }
}
