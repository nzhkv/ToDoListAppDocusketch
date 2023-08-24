//
//  ViewController.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 23.08.2023.
//

import UIKit

class TaskListViewController: UIViewController, AddTaskViewDelegate {
    
    private let tasksListView: TasksListView
    private var viewModel: TasksListViewViewModel
    
    init(viewModel: TasksListViewViewModel) {
        self.viewModel = viewModel
        self.tasksListView = TasksListView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        tasksListView.setAddTaskViewDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(tasksListView)
        NSLayoutConstraint.activate([
            tasksListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tasksListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tasksListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tasksListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tasksListView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        if tasksListView.addTaskViewHeightConstraint.constant == 0 {
            tasksListView.addTaskViewHeightConstraint.constant = 125
        } else {
            tasksListView.addTaskViewHeightConstraint.constant = 0
        }
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    /// реализация делегата по сохранению новой задачи
    func didTapSaveButton(with task: String) {
        let newTask = Task(title: task, status: .planned)
        viewModel.addTaskAction?(newTask)
        viewModel.addTask(newTask)
        tasksListView.reloadData()
    }
    
}

