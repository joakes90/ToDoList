//
//  CoreDataStack.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import Foundation
import CoreData

final class CoreDataStore: PersistenceDelegate {

    static let shared = CoreDataStore()
    
    private lazy var managedContext: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container.viewContext
    }()
    
    private init() {}
    
    func save() throws {
        guard managedContext.hasChanges else { return }
        try managedContext.save()
    }
    
    func delete(item: NSManagedObject) throws {
        managedContext.delete(item)
        try save()
    }
    
    func createManagedObject(for type: ManagedObjectType) -> NSManagedObject {
        let entityName: String
        switch type {
        case .ToDoItem:
            entityName = "ToDoItemManagedObject"
        }
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        return NSManagedObject(entity: entity, insertInto: managedContext)
    }
    
    func fetchAllItems(of type: ManagedObjectType) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: type.entityName)
        do {
            return try managedContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
            return []
        }
    }
}

enum ManagedObjectType {
    case ToDoItem
    
    var entityName: String {
        switch self {
        case .ToDoItem:
            return "ToDoItemManagedObject"
        }
    }
}

protocol PersistenceDelegate {
    func save() throws
    func delete(item: NSManagedObject) throws
    func createManagedObject(for type: ManagedObjectType) -> NSManagedObject
    func fetchAllItems(of type: ManagedObjectType) -> [NSManagedObject]
}
