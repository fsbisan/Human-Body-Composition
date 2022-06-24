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
    
    // MARK: - UIButtons
    
    private lazy var percentOfFatLabel: UILabel = {
        let label = UILabel()
        label.text = "Процент жира в организме: " + resultViewModel.percentOfFat
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dryBodyMassLabel: UILabel = {
        let label = UILabel()
        label.text = "Сухая масса тела: " + resultViewModel.dryBodyMass
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var interpretationOfResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Интерпритация: " + InterpretationOfResults.highFat.rawValue
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - StackViews
    
    private lazy var resultStackView = UIStackView()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupSubviews(resultStackView)
        setupResultStackView(resultStackView, with: percentOfFatLabel, dryBodyMassLabel, interpretationOfResultsLabel)
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
    
    private func setupResultStackView(_ stackView: UIStackView, with arrangedSubviews: UIView...) {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        
        arrangedSubviews.forEach { subview in
            stackView.addArrangedSubview(subview)
        }
    }
    
    private func setConstraints() {
        
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            resultStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            resultStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            resultStackView.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            resultStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - @objc methods
    
    @objc private func close(){
        dismiss(animated: true)
    }
}


