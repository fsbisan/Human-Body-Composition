//
//  StartViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 25.11.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    let user = User()
    var questionNumber = 1
    
    private lazy var segmentedControl: UISegmentedControl = {
        let menuArray = ["male", "female"]
        let segmentedControl = UISegmentedControl(items: menuArray )
        //segmentedControl.frame = CGRect(x: 50, y: 100, width: 200, height: 200)
        segmentedControl.isHidden = true
        return segmentedControl
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "Hello! Please enter your name"
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 1, green: 1, blue: 0.6, alpha: 1)
        
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(red: 0.7, green: 0.3, blue: 0.3, alpha: 1)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func save(){
        guard let text = textField.text else { return }
        switch questionNumber {
        case 1:
            user.name = text
            questionNumber += 1
            segmentedControl.isHidden.toggle()
            textField.isHidden.toggle()
            titleLabel.text = "Choose you sex"
            saveButton.isUserInteractionEnabled = false
            
        case 2:
            textField.text = ""
            segmentedControl.isHidden.toggle()
            textField.isHidden.toggle()
        case 3:
            print(0)
        default:
            print(0)
        }
        print("\(user.name)")
    }
    
    @objc private func goBack(){
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            saveButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 60),
            saveButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.widthAnchor.constraint(equalTo: backButton.widthAnchor, multiplier: 1.0),
            
            backButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 60),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        setupSubviews(textField, saveButton, backButton, titleLabel, segmentedControl)
        setConstraints()
    }
}

