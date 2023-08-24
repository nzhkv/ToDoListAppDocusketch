//
//  DoneTaskTableViewCellViewModel.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 24.08.2023.
//

import Foundation

/// ViewModel кастомной ячейки done
final class DoneTaskTableViewCellViewModel {
    private let taskStatuslabel: String = "\u{25C9}"
    public let taskTextLabel: String
    
    init(taskTextLabel: String) {
        self.taskTextLabel = taskTextLabel
    }
}
