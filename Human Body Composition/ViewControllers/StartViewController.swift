//
//  StartViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 17.12.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: UIButtons
    
    private lazy var startCalculateButton: CustomButton = {
        let button = CustomButton(title: "Начать расчёт")
        button.addTarget(self, action: #selector(goNextVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: CustomButton = {
        let button = CustomButton(title: "Зарегистрироваться")
        button.backgroundColor = MyCustomColors.colorForRegButton.associatedColor
        button.addTarget(self, action: #selector(goNextVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: Private Methods
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        startCalculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            startCalculateButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            startCalculateButton.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: 20),
            startCalculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate ([
            registrationButton.topAnchor.constraint(equalTo: startCalculateButton.bottomAnchor, constant: 40),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: OBJC Methods
    
    @objc private func goNextVC(){
        let rootVC = UserInfoViewController()
        let userInfoNavVC = UINavigationController(rootViewController: rootVC)
        userInfoNavVC.modalPresentationStyle = .fullScreen
        present(userInfoNavVC, animated: true)
    }
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MyCustomColors.bgColorForView.associatedColor
        setupSubviews(startCalculateButton, registrationButton)
        setConstraints()
    }
    
}
