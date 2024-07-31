//
//  ToDoListViewModel.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import Foundation

final class ToDoListViewModel: ObservableObject {
    
    @Published var toDoItems = [ToDoItem]()
    
}