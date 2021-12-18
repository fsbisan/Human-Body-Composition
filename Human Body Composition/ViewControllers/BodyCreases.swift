//
//  BodyCreases.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 18.12.2021.
//

import UIKit

class BodyCreases: UIViewController {
    
    private lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(text: "Введите размер складки на животе", width: 200, height: 100)
        return label
    }()
    
    private func setSubViews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private lazy var creaseTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "размер складки в мм"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 0.6, alpha: 1)
        
        return textField
    }()
    
    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        creaseTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            creaseTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            creaseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            creaseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: creaseTextField.bottomAnchor, constant: 40),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupNavigationBar() {
        title = "Толщина складки"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад", style: .plain, target: self, action: #selector(close)
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
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
    
    @objc private func close() {
       dismiss(animated: true)
    }
    
    @objc private func nextCrease() {
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupNavigationBar()
        setSubViews(titleLabel, creaseTextField, nextButton)
        setConstraints()
    }
}
