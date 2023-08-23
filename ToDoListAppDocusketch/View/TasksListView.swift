//
//  TasksListView.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 23.08.2023.
//

import UIKit

class TasksListView: UIView {
    
    private var addTaskView: AddTaskView!
    
    var addTaskViewHeightConstraint: NSLayoutConstraint!
    
    private let viewModel: TasksListViewViewModel
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //        table.register(DoneTaskTableViewCell.self, forCellReuseIdentifier: DoneTaskTableViewCell.cellIdentifier)
        //        table.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.cellIdentifier)
        
        return table
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "TO DO"
        label.textColor = UIColor.label
        let headerFont = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.font = headerFont
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 30
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 1
        return button
    }()
    
    init(frame: CGRect, viewModel: TasksListViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(headerLabel, tableView, addButton)
        setUpTableView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpTableView() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
    func addConstraints() {
        addTaskView = AddTaskView()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskView.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(addTaskView)
        addTaskViewHeightConstraint = addTaskView.heightAnchor.constraint(equalToConstant: 0)
        addTaskViewHeightConstraint.isActive = true
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            headerLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            addTaskView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            addTaskView.leftAnchor.constraint(equalTo: leftAnchor, constant:  16),
            addTaskView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: addTaskView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func setAddTaskViewDelegate(_ delegate: AddTaskViewDelegate) {
            addTaskView.delegate = delegate
        }
}

