//
//  ToDoItemTests.swift
//  ToDoTests
//
//  Created by Justin Oakes on 8/1/24.
//

import CoreData
import XCTest
@testable import ToDo

final class ToDoItemTests: XCTestCase {

    var mockManagedObject: MockToDoItemManagedObject!
    var mockPersistenceDelegate: MockPersistenceDelegate!
    var toDoItem: ToDoItem!
    var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        mockManagedObject = MockToDoItemManagedObject()
        context = setUpInMemoryManagedObjectContext()
        mockPersistenceDelegate = MockPersistenceDelegate(context: context)
        toDoItem = ToDoItem(managedObject: mockManagedObject, persistenceDelegate: mockPersistenceDelegate)
    }

    override func tearDown() {
        mockManagedObject = nil
        context = nil
        mockPersistenceDelegate = nil
        toDoItem = nil
        super.tearDown()
    }

    func testInitWithManagedObject() {
        // Given
        let id = UUID()
        let name = "Test Item"
        let createdDate = Date()

        mockManagedObject.mockID = id
        mockManagedObject.mockName = name
        mockManagedObject.mockCreatedDate = createdDate
        mockManagedObject.mockIsComplete = false

        // When
        let item = ToDoItem(managedObject: mockManagedObject, persistenceDelegate: mockPersistenceDelegate)

        // Then
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.name, name)
        XCTAssertEqual(item.createdDate, createdDate)
        XCTAssertEqual(item.isComplete, false)
    }

    func testSave() {
        // When
        toDoItem.save()

        // Then
        XCTAssertTrue(mockPersistenceDelegate.saveCalled)
    }

    func testRollback() {
        // When
        toDoItem.rollback()

        // Then
        XCTAssertTrue(mockPersistenceDelegate.rollbackCalled)
    }

    func testDelete() {
        // When
        toDoItem.delete()

        // Then
        XCTAssertTrue(mockPersistenceDelegate.deleteCalled)
    }

    func testToggleComplete() {
        // Given
        let initialCompletionState = toDoItem.isComplete

        // When
        toDoItem.toggleComplete()

        // Then
        XCTAssertNotEqual(initialCompletionState, toDoItem.isComplete)
        XCTAssertTrue(mockPersistenceDelegate.saveCalled)
    }

    func testFetchAll() {
        // When
        let items = mockPersistenceDelegate.fetchAllItems(of: .ToDoItem) as! [ToDoItemManagedObject]

        // Then
        XCTAssertEqual(items.count, 3)
        XCTAssertEqual(items.first?.name, "Item 0")
    }
}
