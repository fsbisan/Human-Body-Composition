//
//  ResultViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.01.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: Public Properties
    
    var user: User!
    
    // MARK: UIButtons
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Процент жира в организме: " + String(format: "%.2f", user.fatBodyMass)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupSubviews(resultLabel)
        setConstraints()
        setupNavigationBar()
    }
    
    // MARK: Private Methods
    
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
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            resultLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            resultLabel.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: @objc methods
    
    @objc private func close(){
        dismiss(animated: true)
    }
}
