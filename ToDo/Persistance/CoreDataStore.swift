//
//  CoreDataStack.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import Foundation
import CoreData

final class CoreDataStore {

    static let shared = CoreDataStore()
    
    private lazy var persistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ToDoItems")
        
        container.loadPersistentStores { _, error in
            if let error {
                // This might be good to surface up to some form of remote logging. Crashlytics maybe?
                //and then possibly fall back to attempting to creating a new store and repopulatoing the data if it's available elsewhere.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private init() {}
}

extension CoreDataStore: PersistanceDelegate {
    
    func save()  throws {
        guard persistantContainer.viewContext.hasChanges else { return }
        try persistantContainer.viewContext.save()
    }
    
    func delete(item: NSManagedObject) throws {
        persistantContainer.viewContext.delete(item)
        try save()
    }
    
    func createManagedObject(type: ManagedObjectType) -> NSManagedObject {
        // This could be expanded to cover multipul entity types
        var entity: NSEntityDescription
        switch type {
        case .ToDoItem:
            entity = NSEntityDescription.entity(forEntityName: "ToDoItemManagedObject"
                                                , in: persistantContainer.viewContext)!
        }
        return NSManagedObject(entity: entity, insertInto: persistantContainer.viewContext)
    }
    
    func readAllRecords() {
    }
}

enum ManagedObjectType {
    case ToDoItem
}

protocol ManagedObjectRepresentable {
    // In theory this could be genericised better to be adopted by ant NSManagedObject subclass
    // not just ToDoItemManagedObject
    var managedObject: ToDoItemManagedObject { get }
    var persistanceDelegate: PersistanceDelegate { get }
    func update() throws
    func delete() throws
}

protocol PersistanceDelegate {
    func save() throws
    func delete(item: NSManagedObject) throws
    func createManagedObject(type: ManagedObjectType) -> NSManagedObject
}
