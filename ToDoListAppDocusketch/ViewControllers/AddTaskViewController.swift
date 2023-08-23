//
//  AddTaskViewController.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 24.08.2023.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    private let addTaskView = AddTaskView()
    private let viewModel: TasksListViewViewModel
    
    init(viewModel: TasksListViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(addTaskView)
        addTaskView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addTaskView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTaskView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
