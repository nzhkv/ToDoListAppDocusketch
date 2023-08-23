//
//  TasksListViewViewModel.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 23.08.2023.
//

import UIKit

final class TasksListViewViewModel: NSObject {
    
    var tasksStorage: TaskStorageProtocol = TaskStorage()
    
    
    var addTaskAction: ((TaskProtocol) -> Void)?
    
    var tasks: [TaskStatus: [TaskProtocol]] = [:] {
        didSet {
            var savingArray: [TaskProtocol] = []
            tasks.forEach {key, value in
                savingArray += value
            }
            tasksStorage.saveTasks(savingArray)
        }
    }
    
    
    var sectionStatusPosition: [TaskStatus] = [.planned, .completed]
    
    func setTasks(_ tasksCollection: [TaskProtocol]) {
        sectionStatusPosition.forEach { taskType in
            tasks[taskType] = []
        }

        tasksCollection.forEach { task in
            tasks[task.status]?.append(task)
        }
    }
    
    func addTask(_ task: TaskProtocol) {
        tasks[task.status]?.insert(task, at: 0)
    }
    
    
    
}

extension TasksListViewViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionStatusPosition.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks[sectionStatusPosition[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let taskType = sectionStatusPosition[section]
        if taskType == .planned {
            return "To Do"
        } else if taskType == .completed {
            return "Completed"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
               guard let cell = tableView.dequeueReusableCell(
                   withIdentifier: ToDoTableViewCell.cellIdentifier,
                   for: indexPath) as? ToDoTableViewCell else {
                   fatalError("Unsupported cell")
               }
               
               // Обратите внимание на toDoTasks вместо tasks[.completed]
               guard let task = tasks[.planned]?[indexPath.row] else {
                   fatalError("Task not found")
               }
               
               cell.configure(with: ToDoTaskTableViewCellViewModel(taskTextLabel: task.title))
               return cell
           }
           if indexPath.section == 1 {
               guard let cell = tableView.dequeueReusableCell(
                   withIdentifier: DoneTaskTableViewCell.cellIdentifier,
                   for: indexPath) as? DoneTaskTableViewCell else {
                   fatalError("Unsupported cell")
               }
               
               // Используйте tasks[.completed] для раздела "Completed"
               guard let task = tasks[.completed]?[indexPath.row] else {
                   fatalError("Task not found")
               }
               
               cell.configure(with: DoneTaskTableViewCellViewModel(taskTextLabel: task.title))
               return cell
           }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let sectionStatus = sectionStatusPosition[indexPath.section]
        if let task = tasks[sectionStatus]?[indexPath.row] {
            cell.textLabel?.text = task.title
        } else {
            cell.textLabel?.text = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.deleteTask(at: indexPath, tableView: tableView)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func deleteTask(at indexPath: IndexPath, tableView: UITableView) {
        let sectionStatus = sectionStatusPosition[indexPath.section]
        tasks[sectionStatus]?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    
//    изменение статуса задачи
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskType = sectionStatusPosition[indexPath.section]
        
        guard var task = tasks[taskType]?[indexPath.row] else {
            return
        }
        
        let newTaskType: TaskStatus = task.status == .planned ? .completed : .planned
        tasks[taskType]?.remove(at: indexPath.row)
        task.status = newTaskType
        tasks[newTaskType]?.insert(task, at: 0)
        
        tableView.reloadData()
    }
    
}

