//
//  ItemSheetViewModelTests.swift
//  ToDoTests
//
//  Created by Justin Oakes on 8/1/24.
//

import SwiftUI
import XCTest
@testable import ToDo

final class ItemSheetViewModelTests: XCTestCase {

    var viewModel: ItemSheetViewModel!
    var mockToDoItem: MockToDoItem!
    @State var shouldDisplaySheet = false
    
    override func setUp() {
        super.setUp()
                super.setUp()
                mockToDoItem = MockToDoItem()
                viewModel = ItemSheetViewModel(toDoItem: mockToDoItem, shouldDisplaySheet: $shouldDisplaySheet)
    }

    override func tearDown() {
        mockToDoItem = nil
        viewModel = nil
        super.tearDown()
    }


    func testSaveToDoItem_callsSaveAndDismiss() {
            // Given
            shouldDisplaySheet = true
            
            // When
            viewModel.saveToDoItem()
            
            // Then
            XCTAssertTrue(mockToDoItem.saveCalled)
            XCTAssertFalse(shouldDisplaySheet)
        }
        
        func testDismiss_callsRollbackAndSetsShouldDisplaySheetToFalse() {
            // Given
            shouldDisplaySheet = true
            
            // When
            viewModel.dismiss()
            
            // Then
            XCTAssertTrue(mockToDoItem.rollbackCalled)
            XCTAssertFalse(shouldDisplaySheet)
        }
}
