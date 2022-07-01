//
//  UserInfoViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 25.11.2021.
//

import UIKit

/// Текст для загооловка поля в зависимости от пола
enum FirstCreaseLabelText: String {
    case forMale = "складка на животе"
    case forFemale = "складка на боку"
}
/// Текст для загооловка поля в зависимости от пола
enum SecondCreaseLabelText: String {
    case forMale = "складка груди"
    case forFemale = "складка на трицепсе"
}
/// Текст для загооловка поля в зависимости от пола
enum ThirdCreaseLabelText: String {
    case forMale = "складка на бедре"
}
/// Отображает экран ввода данных
class UserInfoViewController: UIViewController {
    
    // MARK: Public Properties
    
    weak var activeTextField: UITextField?
    
    var userInfoViewModel: UserInfoViewModelProtocol!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Private Properties
    
    // MARK: - UISegmentedControls
    
    /// Переключатель пола
    private lazy var sexSegmentedControl: UISegmentedControl = {
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
    /// Поле ввода возраста
    private lazy var ageTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите ваш возраст, в годах")
        textField.addTarget(self, action: #selector(ageTFTextDidChange), for: .editingChanged)
        return textField
    }()
    /// Поле ввода веса
    private lazy var weightTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите ваш вес, кг")
        textField.addTarget(self, action: #selector(weightTFTextDidChange), for: .editingChanged)
        textField.keyboardType = .decimalPad
        return textField
    }()
    /// Поле ввода первой складки
    private lazy var firstCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите размер складки в мм")
        textField.addTarget(self, action: #selector(firstCreaseTFDidChange), for: .editingChanged)
        return textField
    }()
    /// Поле ввода второй складки
    private lazy var secondCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите размер складки в мм")
        textField.addTarget(self, action: #selector(secondCreaseTFTextDidChange), for: .editingChanged)
        return textField
    }()
    /// Поле ввода третьей складки
    private let thirdCreaseTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Введите размер складки в мм")
        textField.addTarget(self, action: #selector(thirdCreaseTFTextDidChange), for: .editingChanged)
        return textField
    }()
    
    // MARK: - UILabels
    /// Заголовк для поля ввода возраста
    private lazy var ageLabel: CustomLabel = {
        let label = CustomLabel(text: "Возраст")
        return label
    }()
    
    /// Label отображаемый при невалидных данных в поле возраста
    private let alertAgeLabel: CustomLabel = {
        let label = CustomLabel(text: "Возраст не корректный")
        label.correctText = "возраст корректен"
        label.incorrectText = "возраст неверный"
        label.textColor = .red
        label.isHidden = true
        label.textAlignment = .left
        return label
    }()
    
    private lazy var weightLabel: CustomLabel = {
        let label = CustomLabel(text: "Вес")
        return label
    }()
    
    /// Label отображаемый при невалидных данных в поле веса
    private lazy var alertWeightLabel: CustomLabel = {
        let label = CustomLabel(text: "Вес некорректный")
        label.correctText = "вес корректен"
        label.incorrectText = "вес неверный"
        label.textColor = .red
        label.isHidden = true
        label.textAlignment = .left
        return label
    }()
    /// Заголовок для первой складки
    private lazy var firstCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: FirstCreaseLabelText.forMale.rawValue)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    /// Заголовок для второй складки
    private lazy var secondCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: SecondCreaseLabelText.forMale.rawValue)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    /// Заголовок для третьей складки
    private lazy var thirdCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: ThirdCreaseLabelText.forMale.rawValue)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    /// Label отображаемый при невалидных данных в поле первой складки
    private lazy var alertFirstCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "не корректный размер складки")
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.correctText = "размер складки корректен"
        label.incorrectText = "не корректный размер складки"
        label.textColor = .red
        label.isHidden = true
        label.textAlignment = .left
        return label
    }()
    
    /// Label отображаемый при невалидных данных в поле второй складки
    private lazy var alertSecondCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "не корректный размер складки")
        label.correctText = "размер складки корректен"
        label.incorrectText = "не корректный размер складки"
        label.textColor = .red
        label.isHidden = true
        label.textAlignment = .left
        return label
    }()
    
    /// Label отображаемый при невалидных данных в поле третьей складки
    private lazy var alertThirdCreaseLabel: CustomLabel = {
        let label = CustomLabel(text: "не корректный размер складки")
        label.correctText = "размер складки корректен"
        label.incorrectText = "не корректный размер складки"
        label.textColor = .red
        label.isHidden = true
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - UIButtons
    
    /// Кнопка завершения ввода и перехода на следующий экран
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
        userInfoViewModel = UserInfoViewModel()
        view.backgroundColor = MyCustomColors.bgColorForView.associatedColor
        setupNavigationBar()
        setupScrollView()
        setupSubviews(scrollView)
        nextButton.isEnabled = false
        nextButton.backgroundColor = MyCustomColors.colorForUnActiveState.associatedColor
        nextButton.setTitleColor(.gray, for: .normal)
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
        
        delegate(textFields: ageTextField, weightTextField, firstCreaseTextField, secondCreaseTextField, thirdCreaseTextField)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserInfoViewController.backgroundTap))
        self.mainStackView.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UserInfoViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UserInfoViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Private Methods
    
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
    /// Настройка главного StackView
    private func setupMainStackView(_ arrangedSubviews: UIView...) {
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 12
        mainStackView.alignment = .fill
        
        arrangedSubviews.forEach { subview in
            mainStackView.addArrangedSubview(subview)
        }
    }
    /// настройка StackView с
    private func setupCreaseStackViews(_ stackView: UIStackView, with arrangedSubviews: UIView...) {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        
        arrangedSubviews.forEach { subview in
            stackView.addArrangedSubview(subview)
        }
    }
    /// настройка StackView с заголовком поля и кнопкой инструкции
    private func setupCreaseLBAndInfBTStackViews(_ stackView: UIStackView, with arrangedSubviews: UIView...) {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        arrangedSubviews.forEach { subview in
            stackView.addArrangedSubview(subview)
        }
    }
    
    /// Установка констрейнтов
    private func setConstraints() {
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
   
            sexSegmentedControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            ageTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            weightTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            firstCreaseTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            secondCreaseTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            thirdCreaseTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            
            nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
    }
    /// Связывание allDataIsValid и состояния кнопки перехода далее
    private func SetupValidityState() {
        userInfoViewModel.allDataIsValid.bind { allDataIsValid in
            if allDataIsValid {
                self.nextButton.isEnabled = true
                self.nextButton.setTitleColor(.black, for: .normal)
                self.nextButton.backgroundColor = MyCustomColors.colorForActiveState.associatedColor
            } else {
                self.nextButton.isEnabled = false
                self.nextButton.backgroundColor = MyCustomColors.colorForUnActiveState.associatedColor
                self.nextButton.setTitleColor(.gray, for: .normal)
            }
        }
    }
    // MARK: - @objc methods
    
    @objc private func ageTFTextDidChange() {
        userInfoViewModel.textfieldTextDidChange(text: ageTextField.text, typeOfValidate: .age)
        userInfoViewModel.ageIsValid.bind { [unowned self] value in
            self.alertAgeLabel.isHidden = value
        }
        SetupValidityState()
    }
    
    @objc private func weightTFTextDidChange() {
        userInfoViewModel.textfieldTextDidChange(text: weightTextField.text, typeOfValidate: .weight)
        userInfoViewModel.weightIsValid.bind { [unowned self] value in
            self.alertWeightLabel.isHidden = value
        }
        SetupValidityState()
    }
    
    @objc private func firstCreaseTFDidChange() {
        userInfoViewModel.textfieldTextDidChange(text: firstCreaseTextField.text, typeOfValidate: .firstCrease)
        userInfoViewModel.firstCreaseIsValid.bind { [unowned self] value in
            self.alertFirstCreaseLabel.isHidden = value
        }
        SetupValidityState()
    }
    
    @objc private func secondCreaseTFTextDidChange() {
        userInfoViewModel.textfieldTextDidChange(text: secondCreaseTextField.text, typeOfValidate: .secondCrease)
        userInfoViewModel.secondCreaseIsValid.bind { [unowned self] value in
            self.alertSecondCreaseLabel.isHidden = value
        }
        SetupValidityState()
    }
    
    @objc private func thirdCreaseTFTextDidChange() {
        userInfoViewModel.textfieldTextDidChange(text: thirdCreaseTextField.text, typeOfValidate: .thirdCrease)
        userInfoViewModel.thirdCreaseIsValid.bind { [unowned self] value in
            self.alertThirdCreaseLabel.isHidden = value
        }
        SetupValidityState()
    }
    /// Связывание переключателя пола и отображаемых заголовков полей
    @objc private func toggleSex() {
        switch sexSegmentedControl.selectedSegmentIndex {
        case 1:
            userInfoViewModel?.sex = .female
            firstCreaseLabel.text = FirstCreaseLabelText.forFemale.rawValue
            secondCreaseLabel.text = SecondCreaseLabelText.forFemale.rawValue
            
            showFirstCreaseInstructionButton.imageNameToSend = ImageNames.hipImage.rawValue
            showSecondCreaseInstructionButton.imageNameToSend = ImageNames.armImage.rawValue
        default:
            userInfoViewModel?.sex = .male
            firstCreaseLabel.text = FirstCreaseLabelText.forMale.rawValue
            secondCreaseLabel.text = SecondCreaseLabelText.forMale.rawValue
            
            showFirstCreaseInstructionButton.imageNameToSend = ImageNames.stomachImage.rawValue
            showSecondCreaseInstructionButton.imageNameToSend = ImageNames.breastImage.rawValue
        }
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    /// Переход на экран с результатами
    @objc private func goToNextView() {
        let rootVC = ResultViewController()
        rootVC.resultViewModel = userInfoViewModel?.getResultViewModel()
        let userCreaseNavVC = UINavigationController(rootViewController: rootVC)
        userCreaseNavVC.modalPresentationStyle = .fullScreen
        present(userCreaseNavVC, animated: true)
    }
    /// Переход на экран с инструкцией по замерам
    @objc private func showInstructionVC(sender: CustomButton) {
        let rootVC = InstructionViewController()
        rootVC.instructionsText = sender.instructionTextToSend
        rootVC.imageName = sender.imageNameToSend
        present(rootVC, animated: true)
    }
    /// Поднимаем ScrollView когда клавиатура показалась на экране
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let activeTextField = activeTextField,
              let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            /// если клавиатура не доступна, по каким-то причинам, то не делать ничего
            return
        }
        /// величина подъема
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + 24, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        let activeRect = activeTextField.convert(activeTextField.bounds, to: scrollView)
        scrollView.scrollRectToVisible(activeRect, animated: true)
    }
    /// Когда клавиатура скрывается опускаем назад ScrollView
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    /// Убираем клавиатуру и каретку из текстового поля когда происходит тап в свободном месте
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension UserInfoViewController: UITextFieldDelegate {
    /// Установка градиента заднего плана
    func setGradientBackground() {
        let colorTop =  UIColor(red: 200/255, green: 255/255, blue: 200/255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 100/255, green: 255/255, blue: 100/255, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    /// Делаем текстовые поля делегатами
    func delegate(textFields: UITextField...) {
        textFields.forEach({ textField in
            textField.delegate = self
        })
    }
    
    @objc private func didTapDone() {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(didTapDone))
         let flexBarButton = UIBarButtonItem (
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        
        keyboardToolBar.items = [flexBarButton, doneButton]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}


