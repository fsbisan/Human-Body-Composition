//
//  UserInfoViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 25.11.2021.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    // MARK: Public Properties
    
    var user = User()
    
    // MARK: Private Properties
    
    private var ageIsValid = false
    private var weightIsValid = false
    
    // MARK: UISegmentedControls
    
    private let sexSegmentedControl: UISegmentedControl = {
        let menuArray = ["мужчина", "женщина"]
        let segmentedControl = UISegmentedControl(items: menuArray )
        segmentedControl.backgroundColor = MyCustomColors.colorForActiveState.associatedColor
        segmentedControl.selectedSegmentTintColor = MyCustomColors.bgColorForTF.associatedColor
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    // MARK: UITextFields
    
     let ageTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите ваш возраст")
        textField.addTarget(self, action: #selector(handleAgeTextChange), for: .editingChanged)
        return textField
    }()
    
    private let weightTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите ваш вес")
        textField.addTarget(self, action: #selector(handleWeightTextChange), for: .editingChanged)
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    // MARK: UILabels
    
//    private let sexLabel: CustomLabel = {
//        let label = CustomLabel(text: "Пол")
//        return label
//    }()
//
    private let ageLabel: CustomLabel = {
        let label = CustomLabel(text: "Возраст")
        return label
    }()
    
    private let alertAgeLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        return label
    }()
    
    private let weightLabel: CustomLabel = {
        let label = CustomLabel(text: "Вес")
        return label
    }()
    
    private let alertWeightLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        return label
    }()
    
    // MARK: UIButtons
    
    private let nextButton: CustomButton = {
        let button = CustomButton(title: "Далее")
        button.addTarget(self, action: #selector(goToNextView), for: .touchUpInside)
        return button
    }()
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyCustomColors.bgColorForView.associatedColor
        setupNavigationBar()
        setupSubviews(ageTextField, sexSegmentedControl, nextButton, ageLabel, weightLabel, weightTextField, alertAgeLabel, alertWeightLabel)
        alertAgeLabel.isHidden = true
        nextButton.isEnabled = false
        setButtonActiveAbility()
        setConstraints()
        setGradientBackground()
    }
    
    // MARK: Private Methods
    
    private func showAlertingLabel(_ isValidData: Bool, label: UILabel) {
        label.isHidden = false
        if isValidData {
            label.text = label == alertAgeLabel ? "возраст корректный" : "вес корректный"
            label.textColor = MyCustomColors.colorForActiveState.associatedColor
        } else {
            label.text = label == alertAgeLabel ? "не корректный возраст" : "не корректный вес"
            label.textColor = .red
        }
        setButtonActiveAbility()
    }
    
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
        
//        sexLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate ([
//            sexLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            sexLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            sexLabel.widthAnchor.constraint(equalToConstant: 50)
//        ])
        
        sexSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            sexSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            sexSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            sexSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: sexSegmentedControl.bottomAnchor, constant: 40),
            ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        alertAgeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertAgeLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 10),
            alertAgeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alertAgeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: alertAgeLabel.bottomAnchor, constant: 20),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 20),
            weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        alertWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertWeightLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 10),
            alertWeightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alertWeightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            nextButton.topAnchor.constraint(equalTo: alertWeightLabel.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    // MARK: @objc methods
    
    @objc private func handleAgeTextChange() {
        guard let text = ageTextField.text else { return }
        if let ageNumber = Double(text) {
            switch ageNumber {
            case 10...150:
                user.age = ageNumber
                ageIsValid = true
            default:
                user.age = 0
                ageIsValid = false
            }
            showAlertingLabel(ageIsValid, label: alertAgeLabel)
        } else {
            ageIsValid = false
            showAlertingLabel(ageIsValid, label: alertAgeLabel)
        }
    }
    
    @objc private func handleWeightTextChange() {
        guard let text = weightTextField.text else { return }
        if let weightNumber = Double(text) {
            switch weightNumber {
            case 40...200:
                user.weight = weightNumber
                weightIsValid = true
            default:
                weightIsValid = false
            }
            showAlertingLabel(weightIsValid, label: alertWeightLabel)
        } else {
            weightIsValid = false
            showAlertingLabel(weightIsValid, label: alertWeightLabel)
        }
    }
    
    @objc private func goToNextView() {
        guard let weight = weightTextField.text else { return }
        if let weight = Double(weight) {
            user.weight = weight
        }
        
        switch sexSegmentedControl.selectedSegmentIndex {
        case 1:
            user.sex = .female
        default:
            user.sex = .male
        }
        
        let rootVC = BodyCreases()
        rootVC.user = user
        let userCreaseNavVC = UINavigationController(rootViewController: rootVC)
        userCreaseNavVC.modalPresentationStyle = .fullScreen
        present(userCreaseNavVC, animated: true)
    }
    
    @objc private func close(){
        dismiss(animated: true)
    }
    
    @objc private func setButtonActiveAbility () {
        if ageIsValid, weightIsValid {
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

extension UserInfoViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 200/255, green: 255/255, blue: 200/255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 100/255, green: 255/255, blue: 100/255, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}


