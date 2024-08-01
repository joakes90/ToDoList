//
//  ToDoItem+CoreDataProperties.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//
//

import Foundation
import CoreData

extension ToDoItemManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItemManagedObject> {
        return NSFetchRequest<ToDoItemManagedObject>(entityName: "ToDoItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var createdDate: Date?
    @NSManaged public var id: UUID?
}

extension ToDoItemManagedObject: Identifiable {

}
