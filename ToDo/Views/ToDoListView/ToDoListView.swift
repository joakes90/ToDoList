//
//  ContentView.swift
//  ToDo
//
//  Created by Justin Oakes on 7/31/24.
//

import SwiftUI

struct ToDoListView: View {

    var body: some View {
        NavigationView {
            List {
            }
            .toolbar {
                ToolbarItem {
                    Button(action: { print("Hello World") },
                           label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            Text("Select an item")
        }
    }
}

#Preview {
    ToDoListView()
}
