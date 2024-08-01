//
//  ToDoListViewModelTests.swift
//  ToDoTests
//
//  Created by Justin Oakes on 8/1/24.
//

@testable import ToDo
import CoreData
import XCTest

final class ToDoListViewModelTests: XCTestCase {
    var viewModel: ToDoListViewModel!
    var mockPersistenceDelegate: MockPersistenceDelegate!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        context = setUpInMemoryManagedObjectContext()
        mockPersistenceDelegate = MockPersistenceDelegate(context: context)
        viewModel = ToDoListViewModel(persistenceDelegate: mockPersistenceDelegate)
        
    }

    override func tearDown() {
        viewModel = nil
        mockPersistenceDelegate = nil
        context = nil
        super.tearDown()
    }

    func testRefreshItems() {
        // Given
        XCTAssertEqual(viewModel.toDoItems.count, 3)
        
        // When
        mockPersistenceDelegate.addItem(withName: "New Item")
        viewModel.refreshItems()
        
        // Then
        XCTAssertEqual(viewModel.toDoItems.count, 4)
        XCTAssertTrue(viewModel.toDoItems.contains(where: { $0.name == "New Item"}))
    }

    func testAddButtonTapped() {
        // Given
        XCTAssertNil(viewModel.displayItem)
        XCTAssertFalse(viewModel.shouldDisplaySheet)
        
        // When
        viewModel.addButtonTapped()
        
        // Then
        XCTAssertNotNil(viewModel.displayItem)
        XCTAssertTrue(viewModel.shouldDisplaySheet)
        XCTAssertEqual(viewModel.displayItem?.name, "Unnamed")
    }
    
    func testRenameItem() {
        // Given
        XCTAssertNil(viewModel.displayItem)
        XCTAssertFalse(viewModel.shouldDisplaySheet)
        
        // When
        viewModel.renameItem(item: viewModel.toDoItems.first!)
        
        // Then
        XCTAssertNotNil(viewModel.displayItem)
        XCTAssertTrue(viewModel.shouldDisplaySheet)
    }
    
    func testToggleTaskCompletion() {
        // Given
        guard let firstToDo = viewModel.toDoItems.first else {
            XCTFail("ToDo items not initalized in list")
            return
        }
        XCTAssertFalse(firstToDo.isComplete)
    
        // When
        viewModel.toggleTaskCompletion(item: firstToDo)
        
        // Then
        XCTAssertTrue(firstToDo.isComplete)
    }
}
