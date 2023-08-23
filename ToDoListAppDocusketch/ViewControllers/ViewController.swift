//
//  ViewController.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 23.08.2023.
//

import UIKit

class TaskListViewController: UIViewController {

    private let tasksListView: TasksListView
    private var viewModel: TasksListViewViewModel
    
    init(viewModel: TasksListViewViewModel) {
        self.viewModel = TasksListViewViewModel()
        self.tasksListView = TasksListView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
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
    }

}

