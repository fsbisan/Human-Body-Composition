//
//  StartViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 17.12.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    // MARK: UIButtons
    
    private let startCalculateButton: CustomButton = {
        let button = CustomButton(title: "Расчитать ИМТ")
        button.layer.cornerRadius = 25
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
            startCalculateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            startCalculateButton.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: 60),
            startCalculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            startCalculateButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: OBJC Methods
    
    @objc private func goNextVC() {
        let rootVC = UserInfoViewController()
        let userInfoNavVC = UINavigationController(rootViewController: rootVC)
        userInfoNavVC.modalPresentationStyle = .fullScreen
        present(userInfoNavVC, animated: true)
    }
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews(startCalculateButton)
        setConstraints()
        setGradientBackground()
    }
}

extension StartViewController {
    func setGradientBackground() {
        let colorTop =  UIColor(red: 200/255, green: 255/255, blue: 200/255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 100/255, green: 255/255, blue: 100/255, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
