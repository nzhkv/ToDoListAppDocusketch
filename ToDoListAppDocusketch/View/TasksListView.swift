//
//  TasksListView.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 23.08.2023.
//

import UIKit

class TasksListView: UIView {
    
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
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
            button.backgroundColor = .blue
            button.tintColor = .white
            button.layer.cornerRadius = 25 // Половина высоты/ширины кнопки для создания круглой формы
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            button.setTitle("+", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            headerLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

