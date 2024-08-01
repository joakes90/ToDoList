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
    @Binding var shouldDisplaySheet: Bool

    init(toDoItem: ToDoItem,
         shouldDisplaySheet: Binding<Bool>) {
        self.toDoItem = toDoItem
        self._shouldDisplaySheet = shouldDisplaySheet
    }

    func saveToDoItem() {
        toDoItem.save()
        dismiss()
    }

    func dismiss() {
        toDoItem.rollback()
        shouldDisplaySheet = false
    }
}
