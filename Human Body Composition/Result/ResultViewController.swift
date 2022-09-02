//
//  ResultViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.01.2022.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var resultViewModel: ResultViewModelProtocol! {
        didSet {
            /// настройка внешнего вида элементов интерфейса
            interpretationOfResultView.backgroundColor = UIColor(
                red: CGFloat(resultViewModel.interpretationViewBackgroundColorComponents[0]),
                green: CGFloat(resultViewModel.interpretationViewBackgroundColorComponents[1]),
                blue: CGFloat(resultViewModel.interpretationViewBackgroundColorComponents[2]),
                alpha: CGFloat(resultViewModel.interpretationViewBackgroundColorComponents[3])
            )
            
            topHeader.text = resultViewModel.topHeaderText
            lowHeader.text = resultViewModel.lowHeaderText
            dateOfMeasure.text = resultViewModel.getDate()
            sexLabel.text = resultViewModel.getSex()
            ageLabel.text = resultViewModel.getAge()
            weightLabel.text = resultViewModel.getWeight()
            firstCreaseLabel.text = resultViewModel.getFirstCreaseSize()
            secondCreaseLabel.text = resultViewModel.getSecondCreaseSize()
            thirdCreaseLabel.text = resultViewModel.getThirdCreaseSize()
            interpretationOfResultsLabel.text = resultViewModel.interpretationText
            percentOfFatLabel.text = resultViewModel.percentOfFat
            saveButton.isHidden = !resultViewModel.buttonVisibility
            deleteButton.isHidden = !resultViewModel.buttonVisibility
        }
    }
    
    // MARK: - UIViews
    /// Верхняя половина экрана
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = MyCustomColors.bgColorForTF.associatedColor
        return view
    }()
    /// Разделительная полоска между данными
    private lazy var devisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    /// Нижняя половина экрана c интерпретацией результата
    private lazy var interpretationOfResultView = UIView()
    
    // MARK: - UILabels
    /// Заголовок верхнего поля
    private lazy var topHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    /// Заголовок нижнего поля
    private lazy var lowHeader: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    /// Лэйбл с датой измерения
    private lazy var dateOfMeasure: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var sexLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var firstCreaseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var secondCreaseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var thirdCreaseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var percentOfFatLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dryBodyMassLabel: UILabel = {
        let label = UILabel()
        label.text = resultViewModel.dryBodyMass
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var interpretationOfResultsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - UIButtons
    /// Кнопка сохранения результата
    private lazy var saveButton: CustomButton = {
        let button = CustomButton(title: "Cохранить")
        button.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    /// Кнопка закрытия View
    private lazy var deleteButton: CustomButton = {
        let button = CustomButton()
        button.tintColor = .red
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var sourcesOfTheRecommendationsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(sourcesOfTheRecommendationsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupSubviews(topView, interpretationOfResultView, topHeader, lowHeader,
                      dateOfMeasure, sexLabel, ageLabel, weightLabel, firstCreaseLabel, secondCreaseLabel, thirdCreaseLabel, devisionView, percentOfFatLabel, dryBodyMassLabel,
                      interpretationOfResultsLabel, saveButton, deleteButton, sourcesOfTheRecommendationsButton)
        setConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    /// Настройка NavigationBar
    private func setupNavigationBar() {
        title = "Результат"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад", style: .plain, target: self, action: #selector(goBack)
        )
    }
    /// Добавление элементов во View
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    /// Расстановка констрейнтов
    private func setConstraints() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        interpretationOfResultView.translatesAutoresizingMaskIntoConstraints = false
        topHeader.translatesAutoresizingMaskIntoConstraints = false
        dateOfMeasure.translatesAutoresizingMaskIntoConstraints = false
        devisionView.translatesAutoresizingMaskIntoConstraints = false
        percentOfFatLabel.translatesAutoresizingMaskIntoConstraints = false
        dryBodyMassLabel.translatesAutoresizingMaskIntoConstraints = false
        lowHeader.translatesAutoresizingMaskIntoConstraints = false
        interpretationOfResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        sexLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        firstCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        secondCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdCreaseLabel.translatesAutoresizingMaskIntoConstraints = false
        sourcesOfTheRecommendationsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.bottomAnchor.constraint(equalTo: percentOfFatLabel.bottomAnchor, constant: 20),
            
            interpretationOfResultView.leftAnchor.constraint(equalTo: view.leftAnchor),
            interpretationOfResultView.rightAnchor.constraint(equalTo: view.rightAnchor),
            interpretationOfResultView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            interpretationOfResultView.bottomAnchor.constraint(equalTo: interpretationOfResultsLabel.bottomAnchor, constant: 20),
            
            
            topHeader.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20),
            topHeader.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            dateOfMeasure.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 4),
            dateOfMeasure.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            sexLabel.topAnchor.constraint(equalTo: dateOfMeasure.bottomAnchor, constant: 10),
            sexLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),

            ageLabel.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 5),
            ageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),

            weightLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 5),
            weightLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            firstCreaseLabel.topAnchor.constraint(equalTo: dateOfMeasure.bottomAnchor, constant: 10),
            firstCreaseLabel.leftAnchor.constraint(equalTo: secondCreaseLabel.leftAnchor),

            secondCreaseLabel.topAnchor.constraint(equalTo: firstCreaseLabel.bottomAnchor, constant: 5),
            secondCreaseLabel.leftAnchor.constraint(equalTo: ageLabel.rightAnchor, constant: 16),

            thirdCreaseLabel.topAnchor.constraint(equalTo: secondCreaseLabel.bottomAnchor, constant: 5),
            thirdCreaseLabel.leftAnchor.constraint(equalTo: secondCreaseLabel.leftAnchor),
            
            devisionView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            devisionView.widthAnchor.constraint(equalToConstant: 1),
            devisionView.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 20),
            devisionView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            
            percentOfFatLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 16),
            percentOfFatLabel.topAnchor.constraint(equalTo: devisionView.topAnchor),
            percentOfFatLabel.rightAnchor.constraint(equalTo: devisionView.leftAnchor, constant: -5),
            
            dryBodyMassLabel.leftAnchor.constraint(equalTo: devisionView.rightAnchor, constant: 16),
            dryBodyMassLabel.topAnchor.constraint(equalTo: devisionView.topAnchor),
            dryBodyMassLabel.bottomAnchor.constraint(lessThanOrEqualTo: devisionView.bottomAnchor, constant: 20),
            dryBodyMassLabel.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -16),
            
            lowHeader.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            lowHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            interpretationOfResultsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            interpretationOfResultsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            interpretationOfResultsLabel.topAnchor.constraint(equalTo: lowHeader.bottomAnchor, constant: 16),
            
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            saveButton.topAnchor.constraint(equalTo: interpretationOfResultView.bottomAnchor, constant: 30),
            saveButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            deleteButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor),
            deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            deleteButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor),
            
            sourcesOfTheRecommendationsButton.leftAnchor.constraint(equalTo: lowHeader.rightAnchor, constant: 10),
            sourcesOfTheRecommendationsButton.bottomAnchor.constraint(equalTo: lowHeader.bottomAnchor),
            sourcesOfTheRecommendationsButton.heightAnchor.constraint(equalTo: lowHeader.heightAnchor)
        ])
    }
    
    // MARK: - @objc methods
    @objc private func sourcesOfTheRecommendationsButtonPressed() {
        let rootVC = SourceOfRecommendationViewController()
        present(rootVC, animated: true)
    }
    
    @objc private func saveButtonDidTapped() {
        resultViewModel.saveButtonDidTapped()
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @objc private func closeButtonTapped(){
        dismiss(animated: true)
    }
    
    @objc private func goBack(){
        dismiss(animated: true)
    }
}


