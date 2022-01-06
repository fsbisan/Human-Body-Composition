//
//  BodyCreases.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 18.12.2021.
//

import UIKit

class BodyCreases: UIViewController, UITextFieldDelegate {
    
    // MARK: Public Properties
    
    var user: User!
    
    // MARK: Private Properties
    
    private var numberOfCrease = 1
    private var labelText: String {
        switch numberOfCrease {
        case 1:
            return "Введите размер складки на животе"
        case 2:
            return "Введите размер складки на груди"
        default:
            return "Введите размер сладки на трицепсе"
        }
    }
    
    // MARK: UILabels
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = labelText
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.text = "неверный формат данных!"
        label.textColor = .red
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: UITextFields
    
    private lazy var creaseTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "размер складки в мм"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 0.6, alpha: 1)
        
        return textField
    }()
    
    // MARK: UIButtons
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1)
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(nextCrease), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupNavigationBar()
        setSubViews(titleLabel, creaseTextField, nextButton, alertLabel)
        alertLabel.isHidden = true
        setConstraints()
    }
    
    // MARK: Private Methods
    
    private func setSubViews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        creaseTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            creaseTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            creaseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            creaseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertLabel.topAnchor.constraint(equalTo: creaseTextField.bottomAnchor, constant: 10),
            alertLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alertLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupNavigationBar() {
        title = "Толщины складок"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад", style: .plain, target: self, action: #selector(close)
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func goNext(){
        let rootVC = ResultViewController()
        let userCreaseNavVC = UINavigationController(rootViewController: rootVC)
        userCreaseNavVC.modalPresentationStyle = .fullScreen
        rootVC.user = user
        present(userCreaseNavVC, animated: true)
    }
    
    private func validateData() -> Bool {
        guard let text = creaseTextField.text else { return false }
        let trimText = text.trimmingCharacters(in: .whitespaces)
        if let number = Double(trimText) {
            user.firstCrease = number
            alertLabel.isHidden = true
            return true
        } else {
            alertLabel.isHidden = false
            return false
        }
    }
    // MARK: OBJC Methods
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
    @objc private func nextCrease() {
        switch numberOfCrease {
        case 1:
            guard validateData() else { return }
            numberOfCrease += 1
            titleLabel.text = labelText
        case 2:
            guard let crease = creaseTextField.text else { return }
            if let crease = Double(crease) {
                user.secondCrease = crease
            }
            nextButton.setTitle("Готово", for: .normal)
            numberOfCrease += 1
            titleLabel.text = labelText
        default:
            guard let crease = creaseTextField.text else { return }
            if let crease = Double(crease) {
                user.thirdCrease = crease
            }
            goNext()
        }
    }
}


