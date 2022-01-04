//
//  ResultViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.01.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    var user: User!
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Процент жира в организме: " + String(format: "%.2f", user.fatBodyMass)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupSubviews(resultLabel)
        setConstraints()
    }
}
