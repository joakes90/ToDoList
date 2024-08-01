//
//  MockCoreDataStack.swift
//  ToDoTests
//
//  Created by Justin Oakes on 8/1/24.
//

import CoreData
import Foundation

// Creates an in memory CoreData managed context for mocking
func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)!
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    
    try! persistentStoreCoordinator.addPersistentStore(
        ofType: NSInMemoryStoreType,
        configurationName: nil,
        at: nil,
        options: nil
    )
    
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = persistentStoreCoordinator
    
    return context
}
