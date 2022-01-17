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
    private var firstCreaseIsValid = false
    private var secondCreaseIsValid = false
    private var thirdCreaseIsValid = false
    
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
        textField.addTarget(self, action: #selector(validateTextAgeTF), for: .editingChanged)
        return textField
    }()
    
    private let weightTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите ваш вес")
        textField.addTarget(self, action: #selector(validateTextWeightTF), for: .editingChanged)
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let firstCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Размер складки в мм")
        textField.addTarget(self, action: #selector(validateTextFirstCreaseTF), for: .editingChanged)
        return textField
    }()
    
    private let secondCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Размер складки в мм")
        textField.addTarget(self, action: #selector(validateTextFirstCreaseTF), for: .editingChanged)
        return textField
    }()
    
    private let thirdCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Размер складки в мм")
        textField.addTarget(self, action: #selector(validateTextFirstCreaseTF), for: .editingChanged)
        return textField
    }()
    
    // MARK: UILabels
    
    private lazy var ageLabel: CustomLabel = {
        let label = CustomLabel(text: "Возраст")
        return label
    }()
    
    private let alertAgeLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        label.correctText = "возраст корректен"
        label.incorrectText = "возраст неверный"
        return label
    }()
    
    private lazy var weightLabel: CustomLabel = {
        let label = CustomLabel(text: "Вес")
        return label
    }()
    
    private lazy var alertWeightLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        label.correctText = "вес корректен"
        label.incorrectText = "вес неверный"
        return label
    }()
    
    private lazy var firstCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "Введите складку на животе")
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var secondCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "Введите складку на груди")
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var thirdCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "Введите складку на бедре")
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var alertFirstCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        label.correctText = "размер складки корректен"
        label.incorrectText = "не корректный размер складки"
        return label
    }()
    
    private lazy var alertSecondCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        label.correctText = "размер складки корректен"
        label.incorrectText = "не корректный размер складки"
        return label
    }()
    
    private lazy var alertThirdCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        label.correctText = "размер складки корректен"
        label.incorrectText = "не корректный размер складки"
        return label
    }()
    
    // MARK: UIButtons
    
    private lazy var nextButton: CustomButton = {
        let button = CustomButton(title: "Далее")
        button.addTarget(self, action: #selector(goToNextView), for: .touchUpInside)
        return button
    }()
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyCustomColors.bgColorForView.associatedColor
        setupNavigationBar()
        setupSubviews(ageTextField, sexSegmentedControl, nextButton,
                      ageLabel, weightLabel, weightTextField,
                      alertAgeLabel, alertWeightLabel,
                      firstCreaseLabel, firstCreaseTextField,
                      alertFirstCreaseLabel, secondCreaseLabel, secondCreaseTextField,
                      alertSecondCreaseLabel, thirdCreaseLabel, thirdCreaseTextField, alertThirdCreaseLabel)
        alertAgeLabel.isHidden = true
        nextButton.isEnabled = false
        updateButtonActivityState()
        setConstraints()
        setGradientBackground()
    }
    
    // MARK: Private Methods
    
    private func showAlertingLabel(_ isValidData: Bool, label: CustomLabel) {
        label.isHidden = false
        
        if isValidData {
            label.text = label.correctText
            label.textColor = MyCustomColors.colorForActiveState.associatedColor
        } else {
            label.text = label.incorrectText
            label.textColor = .red
        }
        updateButtonActivityState()
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
        
        sexSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            sexSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
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
        
        firstCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstCreaseLabel.topAnchor.constraint(equalTo: alertWeightLabel.bottomAnchor, constant: 10),
            firstCreaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstCreaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        firstCreaseTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            firstCreaseTextField.topAnchor.constraint(equalTo: firstCreaseLabel.bottomAnchor, constant: 20),
            firstCreaseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            firstCreaseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        alertFirstCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertFirstCreaseLabel.topAnchor.constraint(equalTo: firstCreaseTextField.bottomAnchor, constant: 10),
            alertFirstCreaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alertFirstCreaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        secondCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondCreaseLabel.topAnchor.constraint(equalTo: alertFirstCreaseLabel.bottomAnchor, constant: 10),
            secondCreaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondCreaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        secondCreaseTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            secondCreaseTextField.topAnchor.constraint(equalTo: secondCreaseLabel.bottomAnchor, constant: 20),
            secondCreaseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            secondCreaseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        alertSecondCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertSecondCreaseLabel.topAnchor.constraint(equalTo: secondCreaseTextField.bottomAnchor, constant: 10),
            alertSecondCreaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alertSecondCreaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
       thirdCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thirdCreaseLabel.topAnchor.constraint(equalTo: alertSecondCreaseLabel.bottomAnchor, constant: 10),
            thirdCreaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            thirdCreaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        thirdCreaseTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            thirdCreaseTextField.topAnchor.constraint(equalTo: thirdCreaseLabel.bottomAnchor, constant: 20),
            thirdCreaseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            thirdCreaseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        alertThirdCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertThirdCreaseLabel.topAnchor.constraint(equalTo: thirdCreaseTextField.bottomAnchor, constant: 10),
            alertThirdCreaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alertThirdCreaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    // MARK: @objc methods
    
    @objc private func validateTextAgeTF() {
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
        } else {
            ageIsValid = false
        }
        showAlertingLabel(ageIsValid, label: alertAgeLabel)
    }
    
    @objc private func validateTextWeightTF() {
        guard let text = weightTextField.text else { return }
        if let weightNumber = Double(text) {
            switch weightNumber {
            case 40...200:
                user.weight = weightNumber
                weightIsValid = true
            default:
                weightIsValid = false
            }
        } else {
            weightIsValid = false
        }
        showAlertingLabel(weightIsValid, label: alertWeightLabel)
    }
    
    @objc private func validateTextFirstCreaseTF() {
        guard let text = firstCreaseTextField.text else { return }
        if let creaseNumber = Double(text) {
            switch creaseNumber {
            case 2...60:
                user.firstCrease = creaseNumber
                firstCreaseIsValid = true
            default:
                user.firstCrease = 0
                firstCreaseIsValid = false
            }
        } else {
            firstCreaseIsValid = false
        }
        showAlertingLabel(firstCreaseIsValid, label: alertFirstCreaseLabel)
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
        
        let rootVC = ResultViewController()
        rootVC.user = user
        let userCreaseNavVC = UINavigationController(rootViewController: rootVC)
        userCreaseNavVC.modalPresentationStyle = .fullScreen
        present(userCreaseNavVC, animated: true)
    }
    
    @objc private func close(){
        dismiss(animated: true)
    }
    
    @objc private func updateButtonActivityState () {
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


