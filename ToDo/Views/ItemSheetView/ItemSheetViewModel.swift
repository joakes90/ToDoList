//
//  ItemSheetViewModel.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import Foundation
import SwiftUI

final class ItemSheetViewModel: ObservableObject {
    
    var toDoItem: ToDoItem
    
    init(toDoItem: ToDoItem) {
        self.toDoItem = toDoItem
    }
    
}
