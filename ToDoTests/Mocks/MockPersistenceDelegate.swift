//
//  MockPersistenceDelegate.swift
//  ToDoTests
//
//  Created by Justin Oakes on 8/1/24.
//

import CoreData
import Foundation
@testable import ToDo

class MockPersistenceDelegate: PersistenceDelegate {
    
    var items: [ToDoItemManagedObject] = []
    let context: NSManagedObjectContext

    var saveCalled = false
    var rollbackCalled = false
    var deleteCalled = false
    
    init(context: NSManagedObjectContext) {
            self.context = context
            populate(numberOfItems: 3)
        }

    func fetchAllItems(of type: ManagedObjectType) -> [NSManagedObject] {
        return items
    }

    func save() {
         saveCalled = true
     }

     func rollback() {
         rollbackCalled = true
     }

     func delete(item: NSManagedObject) {
         deleteCalled = true
     }
    
    func createManagedObject(for type: ToDo.ManagedObjectType) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: "ToDoItemManagedObject", in: context)!
                let toDoItem = ToDoItemManagedObject(entity: entity, insertInto: context)
                toDoItem.createdDate = Date()
                // Set other properties as needed
        return toDoItem
    }
    
    func populate(numberOfItems count: Int) {
        for i in 0..<count {
            let name = "Item \(i)"
            let item = createManagedObject(for: .ToDoItem) as! ToDoItemManagedObject
            item.name = name
            items.append(item)
        }
    }
    
    func addItem(withName name: String) {
        let item = createManagedObject(for: .ToDoItem) as! ToDoItemManagedObject
        item.name = name
        items.append(item)
    }

}
