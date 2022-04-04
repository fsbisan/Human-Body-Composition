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
    case forMale = "складка груди"
    case forFemale = "складка на трицепсе"
}

enum ThirdCreaseLabelText: String {
    case forMale = "складка на бедре"
}

class UserInfoViewController: UIViewController {
    
    // MARK: Public Properties
    
    var user = User()
    var activeTextField : UITextField? = nil
    
    // MARK: Private Properties
    
    private var ageIsValid = false
    private var weightIsValid = false
    private var firstCreaseIsValid = false
    private var secondCreaseIsValid = false
    private var thirdCreaseIsValid = false
    
    // MARK: - UISegmentedControls
    
    private let sexSegmentedControl: UISegmentedControl = {
        let menuArray = ["мужчина", "женщина"]
        let segmentedControl = UISegmentedControl(items: menuArray )
        let font = UIFont.systemFont(ofSize: 18)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segmentedControl.backgroundColor = MyCustomColors.colorForActiveState.associatedColor
        segmentedControl.selectedSegmentTintColor = MyCustomColors.bgColorForTF.associatedColor
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(toggleSex), for: .valueChanged)
        
        return segmentedControl
    }()
    
    // MARK: - UITextFields
    
    private lazy var ageTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите ваш возраст, в годах")
        textField.addTarget(self, action: #selector(validateTextAgeTF), for: .editingChanged)
        return textField
    }()
    
    private lazy var weightTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите ваш вес, кг")
        textField.addTarget(self, action: #selector(validateTextWeightTF), for: .editingChanged)
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private lazy var firstCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите размер складки в мм")
        textField.addTarget(self, action: #selector(validateTextFirstCreaseTF), for: .editingChanged)
        return textField
    }()
    
    private lazy var secondCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите размер складки в мм")
        textField.addTarget(self, action: #selector(validateTextSecondCreaseTF), for: .editingChanged)
        return textField
    }()
    
    private let thirdCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите размер складки в мм")
        textField.addTarget(self, action: #selector(validateTextThirdCreaseTF), for: .editingChanged)
        return textField
    }()
    
    // MARK: - UILabels
    
    private lazy var ageLabel: CustomLabel = {
        let label = CustomLabel(text: "Возраст")
        return label
    }()
    
    private let alertAgeLabel: CustomLabel = {
        let label = CustomLabel(text: "0")
        label.correctText = "возраст корректен"
        label.incorrectText = "возраст неверный"
        label.alpha = 0
        return label
    }()
    
    private lazy var weightLabel: CustomLabel = {
        let label = CustomLabel(text: "Вес")
        return label
    }()
    
    private lazy var alertWeightLabel: CustomLabel = {
        let label = CustomLabel(text: "0")
        label.correctText = "вес корректен"
        label.incorrectText = "вес неверный"
        label.alpha = 0
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
        let label = CustomLabel(text: "0")
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.correctText = "размер складки корректен"
        label.incorrectText = "не корректный размер складки"
        label.alpha = 0
        return label
    }()
    
    private lazy var alertSecondCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "0")
        label.correctText = "размер складки корректен"
        label.incorrectText = "не корректный размер складки"
        label.alpha = 0
        return label
    }()
    
    private lazy var alertThirdCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "0")
        label.correctText = "размер складки корректен"
        label.incorrectText = "не корректный размер складки"
        label.alpha = 0
        return label
    }()
    
    // MARK: - UIButtons
    
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
        button.imageNameToSend = ImageNames.stomachImage.rawValue
        return button
    }()
    
    private lazy var showSecondCreaseInstructionButton: CustomButton = {
        let button = CustomButton()

        button.addTarget(self, action: #selector(showInstructionVC), for: .touchUpInside)
        button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        button.instructionTextToSend = InstructionTexts.breast
        button.imageNameToSend = ImageNames.breastImage.rawValue
        return button
    }()
    
    private lazy var showThirdCreaseInstructionButton: CustomButton = {
        let button = CustomButton()

        button.addTarget(self, action: #selector(showInstructionVC), for: .touchUpInside)
        button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        button.instructionTextToSend = InstructionTexts.leg
        button.imageNameToSend = ImageNames.legImage.rawValue
        return button
    }()
    
    // MARK: - UIStackViews
    
    private lazy var mainStackView = UIStackView()
    
    private lazy var ageStackView = UIStackView()
    private lazy var weightStackView = UIStackView()
    
    private lazy var firsCreaseStackView = UIStackView()
    private lazy var secondCreaseStackView = UIStackView()
    private lazy var thirdCreaseStackView = UIStackView()
    
    private lazy var firstCreaseLBAndInfBTStackView = UIStackView()
    private lazy var secondCreaseLBAndInfBTStackView = UIStackView()
    private lazy var thirdCreaseLBAndInfBTStackView = UIStackView()
    // MARK: - UIScrollViews
    
    private lazy var scrollView = UIScrollView()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyCustomColors.bgColorForView.associatedColor
        setupNavigationBar()
        setupScrollView()
        setupSubviews(scrollView)
        nextButton.isEnabled = false
        updateButtonActivityState()
        setupCreaseLBAndInfBTStackViews(firstCreaseLBAndInfBTStackView,
                                        with: firstCreaseLabel, showFirstCreaseInstructionButton)
        setupCreaseLBAndInfBTStackViews(secondCreaseLBAndInfBTStackView,
                                        with: secondCreaseLabel, showSecondCreaseInstructionButton)
        setupCreaseLBAndInfBTStackViews(thirdCreaseLBAndInfBTStackView,
                                        with: thirdCreaseLabel, showThirdCreaseInstructionButton)
        setupCreaseStackViews(ageStackView,
                             with: ageLabel, ageTextField, alertAgeLabel)
        setupCreaseStackViews(weightStackView,
                             with: weightLabel, weightTextField, alertWeightLabel)
        setupCreaseStackViews(firsCreaseStackView,
                             with: firstCreaseLBAndInfBTStackView, firstCreaseTextField, alertFirstCreaseLabel)
        setupCreaseStackViews(secondCreaseStackView,
                             with: secondCreaseLBAndInfBTStackView, secondCreaseTextField, alertSecondCreaseLabel)
        setupCreaseStackViews(thirdCreaseStackView,
                             with: thirdCreaseLBAndInfBTStackView, thirdCreaseTextField, alertThirdCreaseLabel)
        setupMainStackView(sexSegmentedControl, ageStackView, weightStackView,
                        firsCreaseStackView, secondCreaseStackView, thirdCreaseStackView, nextButton)
        setConstraints()
        setGradientBackground()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserInfoViewController.backgroundTap))
        self.mainStackView.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UserInfoViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UserInfoViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Private Methods
    
    private func showAlertingLabel(_ isValidData: Bool, label: CustomLabel) {
        label.alpha = 1
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
    
    private func setupScrollView(){
        scrollView.addSubview(mainStackView)
    }
    
    private func setupMainStackView(_ arrangedSubviews: UIView...) {
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 20
        mainStackView.alignment = .fill
        
        arrangedSubviews.forEach { subview in
            mainStackView.addArrangedSubview(subview)
        }
    }
    
    private func setupCreaseStackViews(_ stackView: UIStackView, with arrangedSubviews: UIView...) {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        
        arrangedSubviews.forEach { subview in
            stackView.addArrangedSubview(subview)
        }
    }
    
    private func setupCreaseLBAndInfBTStackViews(_ stackView: UIStackView, with arrangedSubviews: UIView...) {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        arrangedSubviews.forEach { subview in
            stackView.addArrangedSubview(subview)
        }
    }
    
    private func setConstraints() {
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
   
            
            sexSegmentedControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            ageTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            weightTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            firstCreaseTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            secondCreaseTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            thirdCreaseTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
    }
    
    // MARK: - @objc methods
    
    @objc private func validateTextAgeTF() {
        guard let text = ageTextField.text else { return }
        if let ageNumber = Double(text) {
            switch ageNumber {
            case 10...150:
                ageIsValid = true
            default:
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
            
            showFirstCreaseInstructionButton.imageNameToSend = ImageNames.hipImage.rawValue
            showSecondCreaseInstructionButton.imageNameToSend = ImageNames.armImage.rawValue
        default:
            user.sex = .male
            firstCreaseLabel.text = FirstCreaseLabelText.forMale.rawValue
            secondCreaseLabel.text = SecondCreaseLabelText.forMale.rawValue
            
            showFirstCreaseInstructionButton.imageNameToSend = ImageNames.stomachImage.rawValue
            showSecondCreaseInstructionButton.imageNameToSend = ImageNames.breastImage.rawValue
        }
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
    
    @objc private func goToNextView() {
        
        let rootVC = ResultViewController()
        rootVC.user = user
        let userCreaseNavVC = UINavigationController(rootViewController: rootVC)
        userCreaseNavVC.modalPresentationStyle = .fullScreen
        present(userCreaseNavVC, animated: true)
    }
    
    @objc private func showInstructionVC(sender: CustomButton) {
        let rootVC = InstructionViewController()
        rootVC.instructionsText = sender.instructionTextToSend
        rootVC.imageName = sender.imageNameToSend
        present(rootVC, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        // go through all of the textfield inside the view, and end editing thus resigning first responder
        // ie. it will trigger a keyboardWillHide notification
        self.view.endEditing(true)
    }
}

extension UserInfoViewController: UITextFieldDelegate {
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 200/255, green: 255/255, blue: 200/255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 100/255, green: 255/255, blue: 100/255, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}


