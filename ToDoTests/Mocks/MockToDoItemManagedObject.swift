//
//  MockToDoItemManagedObject.swift
//  ToDoTests
//
//  Created by Justin Oakes on 8/1/24.
//

import Foundation
@testable import ToDo

class MockToDoItemManagedObject: ToDoItemManagedObject {
    var mockID: UUID?
    var mockName: String?
    var mockIsComplete: Bool = false
    var mockCreatedDate: Date?

    override var id: UUID? {
        get { return mockID }
        set { mockID = newValue }
    }

    override var name: String? {
        get { return mockName }
        set { mockName = newValue }
    }

    override var isComplete: Bool {
        get { return mockIsComplete }
        set { mockIsComplete = newValue }
    }

    override var createdDate: Date? {
        get { return mockCreatedDate }
        set { mockCreatedDate = newValue }
    }
}
