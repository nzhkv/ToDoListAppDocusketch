//
//  TaskStorage.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 23.08.2023.
//

import Foundation

import Foundation

protocol TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol]
//    func saveTasks(_ tasks: [TaskProtocol])
}

class TaskStorage: TaskStorageProtocol {
    func loadTasks() -> [TaskProtocol] {
        // временная реализация
        let testTasks: [TaskProtocol] = [
            Task(title: "Buy milk", status: .planned),
            Task(title: "Wash kat", status: .planned),
            Task(title: "Buy new vacuumcleaner", status: .completed),
            Task(title: "Learn SWIFT", status: .completed),
            Task(title: "Call parents", status: .planned),
            Task(title: "Invate David, Jack, Leonardo, Will and Brus to the party", status: .planned)
        ]
        return testTasks
    }
    
    
}
