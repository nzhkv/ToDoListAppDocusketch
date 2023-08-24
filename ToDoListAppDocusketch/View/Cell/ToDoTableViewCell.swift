//
//  ToDoTableViewCell.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 24.08.2023.
//

import UIKit

/// кастомная ячейка To Do
class ToDoTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ToDoCell"
    
    let taskStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{25CB}"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(taskStatusLabel, taskTextLabel)
        
        NSLayoutConstraint.activate([
            taskStatusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskStatusLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            taskTextLabel.leadingAnchor.constraint(equalTo: taskStatusLabel.leadingAnchor, constant: 25),
            taskTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            taskTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            contentView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskTextLabel.text = nil
    }
    
    public func configure(with viewModel: ToDoTaskTableViewCellViewModel) {
        taskTextLabel.text = viewModel.taskTextLabel
    }
    
}

