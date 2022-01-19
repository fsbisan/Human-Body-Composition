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
    
    private var creaseIsValid = false
    private var creaseNumber = 1
    private var labelText: String {
        switch creaseNumber {
        case 1:
            return "Введите размер складки на животе"
        case 2:
            return "Введите размер складки на груди"
        default:
            return "Введите размер сладки на трицепсе"
        }
    }
    
    // MARK: UILabels
    
    private lazy var CreaseLabel: UILabel = {
        let label = CustomLabel(text: labelText)
        label.numberOfLines = 0
        return label
    }()
    
    private let alertCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    // MARK: UITextFields
    
    private let creaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Размер складки в мм")

        return textField
    }()
    
    // MARK: UIButtons
    
    private let nextButton: CustomButton = {
        let button = CustomButton(title: "Далее")
        button.addTarget(self, action: #selector(nextCrease), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyCustomColors.bgColorForView.associatedColor
        setupNavigationBar()
        setSubViews(CreaseLabel, creaseTextField, nextButton, alertCreaseLabel)
        setConstraints()
        setButtonActiveAbility()
    }
    
    // MARK: Private Methods
    
    private func setSubViews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        CreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            CreaseLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            CreaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            CreaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        creaseTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            creaseTextField.topAnchor.constraint(equalTo: CreaseLabel.bottomAnchor, constant: 20),
            creaseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            creaseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        alertCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertCreaseLabel.topAnchor.constraint(equalTo: creaseTextField.bottomAnchor, constant: 10),
            alertCreaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alertCreaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: alertCreaseLabel.bottomAnchor, constant: 20),
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
    
    private func goToNextView(){
        let rootVC = ResultViewController()
        let userCreaseNavVC = UINavigationController(rootViewController: rootVC)
        userCreaseNavVC.modalPresentationStyle = .fullScreen
        rootVC.user = user
        present(userCreaseNavVC, animated: true)
    }
      
    private func showAlertingLabel(_ isValidData: Bool) {
        if isValidData {
            alertCreaseLabel.isHidden = false
            alertCreaseLabel.text = "размер корректен"
            alertCreaseLabel.textColor = .blue
        } else {
            alertCreaseLabel.isHidden = false
            alertCreaseLabel.text =  "не корректный размер"
            alertCreaseLabel.textColor = .red
        }
        setButtonActiveAbility()
    }
    // MARK: OBJC Methods
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
    @objc private func nextCrease() {
        switch creaseNumber {
        case 1:
            creaseNumber += 1
            CreaseLabel.text = labelText
            creaseTextField.text = ""
            creaseIsValid = false
            alertCreaseLabel.isHidden = true
            setButtonActiveAbility()
        case 2:
            guard let crease = creaseTextField.text else { return }
            if let crease = Double(crease) {
                user.secondCrease = crease
            }
            nextButton.setTitle("Готово", for: .normal)
            creaseNumber += 1
            CreaseLabel.text = labelText
            creaseTextField.text = ""
            creaseIsValid = false
            alertCreaseLabel.isHidden = true
            setButtonActiveAbility()
        default:
            guard let crease = creaseTextField.text else { return }
            if let crease = Double(crease) {
                user.thirdCrease = crease
            }
            goToNextView()
        }
    }
    
    @objc private func handleCreaseTextChange() {
        guard let text = creaseTextField.text else { return }
        if let creaseNumber = Double(text) {
            switch creaseNumber {
            case 2...60:
                user.age = creaseNumber
                creaseIsValid = true
            default:
                user.age = 0
                creaseIsValid = false
            }
            showAlertingLabel(creaseIsValid)
        } else {
            creaseIsValid = false
            showAlertingLabel(creaseIsValid)
        }
    }
    
    @objc private func setButtonActiveAbility () {
        if creaseIsValid {
            nextButton.isEnabled = true
            nextButton.setTitleColor(.black, for: .normal)
            nextButton.backgroundColor = MyCustomColors.colorForActiveState.associatedColor
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = MyCustomColors.colorForUnActiveState.associatedColor
            nextButton.setTitleColor(.gray, for: .normal)
        }
    }
}


