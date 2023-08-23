//
//  Task.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 23.08.2023.
//

import Foundation

protocol TaskProtocol {
    var title: String { get set }
    var status: TaskStatus { get set }
}

struct Task: TaskProtocol {
    var title: String
    var status: TaskStatus
}

enum TaskStatus: Int {
    case planned
    case completed
}
