//
//  ResultViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.01.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var resultViewModel: ResultViewModelProtocol!
    
    // MARK: - UIViews
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = MyCustomColors.bgColorForTF.associatedColor
        return view
    }()
    
    private lazy var devisionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.6, green: 1, blue: 0.6, alpha: 1)
        return view
    }()
    
    private lazy var interpretationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = resultViewModel.getInterpretationBackGroundColor()
        return view
    }()
    // MARK: - UILabels
    
    private lazy var topHeader: UILabel = {
        let label = UILabel()
        label.text = "ИЗМЕРЕНИЯ"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var lowHeader: UILabel = {
        let label = UILabel()
        label.text = "ИНЕТЕРПРЕТАЦИЯ"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var dateOfMeasure: UILabel = {
        let label = UILabel()
        label.text = resultViewModel.getDate()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var percentOfFatLabel: UILabel = {
        let label = UILabel()
        label.text = resultViewModel.percentOfFat
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dryBodyMassLabel: UILabel = {
        let label = UILabel()
        label.text = resultViewModel.dryBodyMass
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var interpretationOfResultsLabel: UILabel = {
        let label = UILabel()
        label.text = resultViewModel.getInterpretation()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - UIButtons
    
    private lazy var saveButton: CustomButton = {
        let button = CustomButton(title: "Cохранить")
//        button.addTarget(self, action: #selector(goToNextView), for: .touchUpInside)
        return button
    }()

    private lazy var deleteButton: CustomButton = {
        let button = CustomButton()
        button.tintColor = .red
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupSubviews(topView, interpretationBackgroundView, topHeader, lowHeader,
                      dateOfMeasure, devisionView, percentOfFatLabel, dryBodyMassLabel,
                      interpretationOfResultsLabel, saveButton, deleteButton)
        setConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        title = "Результат"
        
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
        topView.translatesAutoresizingMaskIntoConstraints = false
        interpretationBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        topHeader.translatesAutoresizingMaskIntoConstraints = false
        dateOfMeasure.translatesAutoresizingMaskIntoConstraints = false
        devisionView.translatesAutoresizingMaskIntoConstraints = false
        percentOfFatLabel.translatesAutoresizingMaskIntoConstraints = false
        dryBodyMassLabel.translatesAutoresizingMaskIntoConstraints = false
        lowHeader.translatesAutoresizingMaskIntoConstraints = false
        interpretationOfResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.33),
            
            interpretationBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            interpretationBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            interpretationBackgroundView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            interpretationBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            topHeader.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            topHeader.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            dateOfMeasure.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 4),
            dateOfMeasure.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            devisionView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            devisionView.widthAnchor.constraint(equalToConstant: 2),
            devisionView.topAnchor.constraint(greaterThanOrEqualTo: dateOfMeasure.bottomAnchor, constant: 20),
            devisionView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16),
            
            percentOfFatLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 16),
            percentOfFatLabel.topAnchor.constraint(equalTo: devisionView.topAnchor),
            percentOfFatLabel.bottomAnchor.constraint(equalTo: devisionView.bottomAnchor),
            percentOfFatLabel.rightAnchor.constraint(equalTo: devisionView.leftAnchor, constant: -16),
            
            dryBodyMassLabel.leftAnchor.constraint(equalTo: devisionView.rightAnchor, constant: 16),
            dryBodyMassLabel.topAnchor.constraint(equalTo: devisionView.topAnchor),
            dryBodyMassLabel.bottomAnchor.constraint(lessThanOrEqualTo: devisionView.bottomAnchor, constant: 20),
            dryBodyMassLabel.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -16),
            
            lowHeader.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            lowHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            interpretationOfResultsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            interpretationOfResultsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            interpretationOfResultsLabel.topAnchor.constraint(equalTo: lowHeader.bottomAnchor, constant: 10),
            
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            saveButton.topAnchor.constraint(equalTo: interpretationBackgroundView.bottomAnchor, constant: 30),
            saveButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            deleteButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor),
            deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            deleteButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor)
            
        ])
    }
    
    // MARK: - @objc methods
    
    @objc private func close(){
        dismiss(animated: true)
    }
}


