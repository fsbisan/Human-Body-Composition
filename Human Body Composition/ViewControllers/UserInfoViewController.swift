//
//  UserInfoViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 25.11.2021.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    let user = User()
    
    // MARK: UISegmentedControls
    
    private lazy var segmentedControl: UISegmentedControl = {
        let menuArray = ["мужчина", "женщина"]
        let segmentedControl = UISegmentedControl(items: menuArray )
        return segmentedControl
    }()
    
    // MARK: UITextFields
    
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Введите ваш возраст"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 0.6, alpha: 1)
        
        return textField
    }()
    
    private lazy var weightTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Введите ваш вес, кг"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 0.6, alpha: 1)
        
        return textField
    }()
    
    // MARK: UILabels
    
    private lazy var sexLabel: CustomLabel = {
        let textField = CustomLabel(text: "Ваш пол", width: 200, height: 50)
        return textField
    }()
    
    private lazy var ageLabel: CustomLabel = {
        let textField = CustomLabel(text: "Ваш возраст(полных лет)", width: 200, height: 50)
        return textField
    }()
    
    private lazy var weightLabel: CustomLabel = {
        let textField = CustomLabel(text: "Ваш вес, кг", width: 200, height: 50)
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
        button.addTarget(self, action: #selector(goNext), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: @objc Functions
    
    @objc private func goNext(){
        let rootVC = BodyCreases()
        let userCreaseNavVC = UINavigationController(rootViewController: rootVC)
        userCreaseNavVC.modalPresentationStyle = .fullScreen
        present(userCreaseNavVC, animated: true)
    }
    
    @objc private func close(){
       dismiss(animated: true)
    }
    
    // MARK: Private Functions
    
    private func setupNavigationBar() {
        title = "Введите данные"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад", style: .plain, target: self, action: #selector(close)
        )
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        
        sexLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            sexLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            sexLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sexLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            segmentedControl.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 40),
            ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate ([
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 40),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate ([
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 20),
            weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            nextButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
        setupNavigationBar()
        setupSubviews(ageTextField, segmentedControl, nextButton, sexLabel, ageLabel, weightLabel, weightTextField)
        setConstraints()
    }
}




