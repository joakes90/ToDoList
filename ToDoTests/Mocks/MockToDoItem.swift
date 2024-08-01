//
//  MockToDoItem.swift
//  ToDoTests
//
//  Created by Justin Oakes on 8/1/24.
//

import Foundation
@testable import ToDo

class MockToDoItem: ToDoItem {
    var saveCalled = false
    var rollbackCalled = false

    override func save() {
        saveCalled = true
    }

    override func rollback() {
        rollbackCalled = true
    }
}
