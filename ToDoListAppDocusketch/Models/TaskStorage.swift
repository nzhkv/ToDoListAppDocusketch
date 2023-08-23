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
    func saveTasks(_ tasks: [TaskProtocol])
}

class TaskStorage: TaskStorageProtocol {
    let testData = true
//    let testData = false

    private var storage = UserDefaults.standard
    var storageKey: String = "tasks"
    
    private enum TaskKey: String{
        case title
        case status
    }
    
    func loadTasks() -> [TaskProtocol] {
        if testData {
            let testTasks: [TaskProtocol] = [
                Task(title: "Buy milk", status: .planned),
                Task(title: "Wash kat", status: .planned),
                Task(title: "Buy new vacuumcleaner", status: .completed),
                Task(title: "Learn SWIFT", status: .completed),
                Task(title: "Call parents", status: .planned),
                Task(title: "Invate friends on the party", status: .planned)
            ]
            return testTasks
        } else {
            var resultTasks: [TaskProtocol] = []
            let tasksFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
            for task in tasksFromStorage {
                guard let title = task[TaskKey.title.rawValue],
                      let statusRaw = task[TaskKey.status.rawValue] else {
                    continue
                }
                let status: TaskStatus = (statusRaw == "planned") ? .planned : .completed
                
                resultTasks.append(Task(title: title, status: status))
            }
            
            return resultTasks
        }
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        var arrayForStorage: [[String:String]] = []
        tasks.forEach { task in
            var newElementForStorage: Dictionary<String,String> = [:]
            newElementForStorage[TaskKey.title.rawValue] = task.title
            newElementForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "completed"
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
    
}
