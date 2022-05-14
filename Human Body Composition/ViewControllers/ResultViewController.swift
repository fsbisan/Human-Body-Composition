//
//  ResultViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.01.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var user: User!
    
    // MARK: - UIButtons
    
    private lazy var percentOfFatLabel: UILabel = {
        let label = UILabel()
        label.text = "Процент жира в организме: " + String(format: "%.2f", user.fatBodyMass)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var dryBodyMassLabel: UILabel = {
        let label = UILabel()
        label.text = "Процент жира в организме: " + String(format: "%.2f", user.fatBodyMass)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var interpretationOfResultLabel: UILabel = {
        let label = UILabel()
        label.text = "Процент жира в организме: " + String(format: "%.2f", user.fatBodyMass)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    // MARK: - Stack Views
    
    private var mainStackView = UIStackView()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupMainStackView(percentOfFatLabel, dryBodyMassLabel, interpretationOfResultLabel)
        setupSubviews(mainStackView)
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
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250)
        ])
    }
    
    private func setupMainStackView(_ arrangedSubviews: UIView...) {
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .leading
        
        arrangedSubviews.forEach { subview in
            mainStackView.addArrangedSubview(subview)
        }
    }
    
    // MARK: - @objc methods
    
    @objc private func close(){
        dismiss(animated: true)
    }
}
