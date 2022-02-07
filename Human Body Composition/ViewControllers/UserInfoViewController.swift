//
//  UserInfoViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 25.11.2021.
//

import UIKit

enum FirstCreaseLabelText: String {
    case forMale = "складка на животе"
    case forFemale = "складка на боку"
}

enum SecondCreaseLabelText: String {
    case forMale = " складка груди"
    case forFemale = "складка на трицепсе"
}

enum ThirdCreaseLabelText: String {
    case forMale = "складка на бедре"
}

class UserInfoViewController: UIViewController {
    
    // MARK: Public Properties
    
    var user = User()
    
    // MARK: Private Properties
    
    private var ageIsValid = false
    private var weightIsValid = false
    private var firstCreaseIsValid = false
    private var secondCreaseIsValid = false
    private var thirdCreaseIsValid = false
    
    private var firstCreaseText = "введите складку на животе"
    private var secondCreaseText = "Введите складку на груди"
    private var thirdCreaseText = "Введите складку на бедре"
    
    // MARK: UISegmentedControls
    
    private let sexSegmentedControl: UISegmentedControl = {
        let menuArray = ["мужчина", "женщина"]
        let segmentedControl = UISegmentedControl(items: menuArray )
        segmentedControl.backgroundColor = MyCustomColors.colorForActiveState.associatedColor
        segmentedControl.selectedSegmentTintColor = MyCustomColors.bgColorForTF.associatedColor
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(toggleSex), for: .valueChanged)
        
        return segmentedControl
    }()
    
    // MARK: UITextFields
    
    private lazy var mainStackView = UIStackView()
    
    private lazy var ageStackView = UIStackView()
    private lazy var weightStackView = UIStackView()
    
    private lazy var firsCreaseStackView = UIStackView()
    private lazy var secondCreaseStackView = UIStackView()
    private lazy var thirdCreaseStackView = UIStackView()
    
    private func setupCreaseStackView(_ stackView: UIStackView, with arrangedSubviews: UIView...) {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        
        arrangedSubviews.forEach { subview in
            stackView.addArrangedSubview(subview)
        }
    }
    
    private func setupMainStackView(arrangedSubviews: UIView...) {
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalCentering
        mainStackView.alignment = .fill
        
        arrangedSubviews.forEach { subview in
            mainStackView.addArrangedSubview(subview)
        }
    }
    
    let ageTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите ваш возраст")
        textField.addTarget(self, action: #selector(validateTextAgeTF), for: .editingChanged)
        return textField
    }()
    
    private lazy var weightTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите ваш вес")
        textField.addTarget(self, action: #selector(validateTextWeightTF), for: .editingChanged)
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private lazy var firstCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Размер складки в мм")
        textField.addTarget(self, action: #selector(validateTextFirstCreaseTF), for: .editingChanged)
        return textField
    }()
    
    private lazy var secondCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Размер складки в мм")
        textField.addTarget(self, action: #selector(validateTextSecondCreaseTF), for: .editingChanged)
        return textField
    }()
    
    private let thirdCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Размер складки в мм")
        textField.addTarget(self, action: #selector(validateTextThirdCreaseTF), for: .editingChanged)
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
        let label = CustomLabel(text: FirstCreaseLabelText.forMale.rawValue)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var secondCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: SecondCreaseLabelText.forMale.rawValue)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var thirdCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: ThirdCreaseLabelText.forMale.rawValue)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var alertFirstCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        label.font = UIFont.italicSystemFont(ofSize: 14)
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
        let button = CustomButton(title: "Расчитать")
        button.addTarget(self, action: #selector(goToNextView), for: .touchUpInside)
        return button
    }()
    
    private lazy var showFirstCreaseInstructionButton: CustomButton = {
        let button = CustomButton()

        button.addTarget(self, action: #selector(showInstructionVC(sender:)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        button.instructionTextToSend = InstructionTexts.stomach
        return button
    }()
    
    private lazy var showSecondCreaseInstructionButton: CustomButton = {
        let button = CustomButton()

        button.addTarget(self, action: #selector(showInstructionVC), for: .touchUpInside)
        button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        button.instructionTextToSend = InstructionTexts.breast
        return button
    }()
    
    private lazy var showThirdCreaseInstructionButton: CustomButton = {
        let button = CustomButton()

        button.addTarget(self, action: #selector(showInstructionVC), for: .touchUpInside)
        button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        button.instructionTextToSend = InstructionTexts.leg
        return button
    }()
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyCustomColors.bgColorForView.associatedColor
        setupNavigationBar()
        setupSubviews(mainStackView)
        alertAgeLabel.isHidden = true
        nextButton.isEnabled = false
        updateButtonActivityState()
        setupCreaseStackView(ageStackView,
                             with: ageLabel, ageTextField, alertAgeLabel)
        setupCreaseStackView(weightStackView,
                             with: weightLabel, weightTextField, alertWeightLabel)
        setupCreaseStackView(firsCreaseStackView,
                             with: firstCreaseLabel, firstCreaseTextField, alertFirstCreaseLabel)
        setupCreaseStackView(secondCreaseStackView,
                             with: secondCreaseLabel, secondCreaseTextField, alertSecondCreaseLabel)
        setupCreaseStackView(thirdCreaseStackView,
                             with: thirdCreaseLabel, thirdCreaseTextField, alertThirdCreaseLabel)
        setupMainStackView(arrangedSubviews:
                        sexSegmentedControl, ageStackView, weightStackView,
                        firsCreaseStackView, secondCreaseStackView, thirdCreaseStackView, nextButton)
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
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            ageTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            weightTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            firstCreaseTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            secondCreaseTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            thirdCreaseTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            
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
    
    @objc private func validateTextSecondCreaseTF() {
        guard let text = secondCreaseTextField.text else { return }
        if let creaseNumber = Double(text) {
            switch creaseNumber {
            case 2...60:
                user.secondCrease = creaseNumber
                secondCreaseIsValid = true
            default:
                user.secondCrease = 0
                secondCreaseIsValid = false
            }
        } else {
            secondCreaseIsValid = false
        }
        showAlertingLabel(secondCreaseIsValid, label: alertSecondCreaseLabel)
    }
    
    @objc private func validateTextThirdCreaseTF() {
        guard let text = thirdCreaseTextField.text else { return }
        if let creaseNumber = Double(text) {
            switch creaseNumber {
            case 2...60:
                user.thirdCrease = creaseNumber
                thirdCreaseIsValid = true
            default:
                user.thirdCrease = 0
                thirdCreaseIsValid = false
            }
        } else {
            thirdCreaseIsValid = false
        }
        showAlertingLabel(thirdCreaseIsValid, label: alertThirdCreaseLabel)
    }
    
    @objc private func toggleSex() {
        switch sexSegmentedControl.selectedSegmentIndex {
        case 1:
            user.sex = .female
            firstCreaseLabel.text = FirstCreaseLabelText.forFemale.rawValue
            secondCreaseLabel.text = SecondCreaseLabelText.forFemale.rawValue
        default:
            user.sex = .male
            firstCreaseLabel.text = FirstCreaseLabelText.forMale.rawValue
            secondCreaseLabel.text = SecondCreaseLabelText.forMale.rawValue
        }
    }
    
    @objc private func goToNextView() {
        
        let rootVC = ResultViewController()
        rootVC.user = user
        let userCreaseNavVC = UINavigationController(rootViewController: rootVC)
        userCreaseNavVC.modalPresentationStyle = .fullScreen
        present(userCreaseNavVC, animated: true)
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
    @objc private func updateButtonActivityState() {
        if ageIsValid, weightIsValid, firstCreaseIsValid, secondCreaseIsValid, thirdCreaseIsValid {
            nextButton.isEnabled = true
            nextButton.setTitleColor(.black, for: .normal)
            nextButton.backgroundColor = MyCustomColors.colorForActiveState.associatedColor
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = MyCustomColors.colorForUnActiveState.associatedColor
            nextButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    @objc private func showInstructionVC(sender: CustomButton) {
        let rootVC = InstructionViewController()
        rootVC.instructionsText = sender.instructionTextToSend
        present(rootVC, animated: true)
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


