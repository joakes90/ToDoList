//
//  ToDoItem+CoreDataClass.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//
//

import Foundation
import CoreData

public class ToDoItemManagedObject: NSManagedObject {

    var toDoItem: ToDoItem {
        ToDoItem(managedObject: self)
    }
}
