//
//  AddTaskView.swift
//  ToDoListAppDocusketch
//
//  Created by Nikolay Zhukov on 23.08.2023.
//

import UIKit

/// протокол делегата на сохоанение новой задачи
protocol AddTaskViewDelegate: AnyObject {
    func didTapSaveButton(with task: String)
}

/// View с кнопкой и textfield для добавления новой задачи
class AddTaskView: UIView {
    
    var delegate: AddTaskViewDelegate?
    
    private var bottomElementsConstraint: NSLayoutConstraint!
    
    private let taskTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.placeholder = "New TO-DO"
        textField.borderStyle = .none
        
        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.blue.cgColor
        bottomLine.frame = CGRect(x: 0, y: 0, width: 0, height: 1)
        textField.layer.addSublayer(bottomLine)
        
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.backgroundColor = .blue
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 1
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        backgroundColor = .systemBackground
        addSubviews(taskTextField, addButton)
        
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomElementsConstraint = addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        
        NSLayoutConstraint.activate([
            //            taskTextField.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            taskTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            taskTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            addButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 80),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            
            bottomElementsConstraint
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.taskTextField.isHidden = self?.frame.height == 0
            self?.addButton.isHidden = self?.frame.height == 0
            self?.bottomElementsConstraint.constant = self?.frame.height == 0 ? 0 : -8
        }
    }
    
    @objc private func addButtonTapped() {
        let title = taskTextField.text ?? ""
        delegate?.didTapSaveButton(with: title)
        taskTextField.text = ""
    }
}
