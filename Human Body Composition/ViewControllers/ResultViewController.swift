//
//  ResultViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.01.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    var user: User!
    
    private lazy var sexLabel: CustomLabel = {
        let textField = CustomLabel(text: "Ваш пол", width: 200, height: 50)
        return textField
    }()
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        sexLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            sexLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            sexLabel.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: 20),
            sexLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupSubviews(sexLabel)
        sexLabel.text = "Ura, \(user.name)"
    }
    
    // MARK: - Navigation
    
}
