//
//  InstructionViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 27.01.2022.
//

import UIKit


/// Отображает экран с инструкцией
class InstructionViewController: UIViewController {
    
    // MARK: - Private Properties
    var instructionViewModel: InstructionViewModelProtocol!
    
    var instructionsText: InstructionTexts!
    var imageName: String!
   
    // MARK: - UIButtons
    
    private lazy var closeButton: CustomButton = {
        let button = CustomButton(title: "Понятно")
        button.addTarget(self, action: #selector(closeInstructionVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UIImages
    
    private lazy var sketchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - UILabels
    
    private lazy var instructionLabel: CustomLabel = {
        let label = CustomLabel(text: instructionsText.rawValue)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(closeButton, sketchImage, instructionLabel)
        setConstraints()
    }
    
    // MARK: Private Methods
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    // MARK: - OBJC Methods
    
    private func setConstraints() {
        
        sketchImage.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sketchImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            sketchImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            sketchImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sketchImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
   
            instructionLabel.topAnchor.constraint(equalTo: sketchImage.bottomAnchor, constant: 16),
            instructionLabel.leadingAnchor.constraint(equalTo: sketchImage.leadingAnchor),
            instructionLabel.trailingAnchor.constraint(equalTo: sketchImage.trailingAnchor),
     
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            closeButton.leadingAnchor.constraint(equalTo: sketchImage.leadingAnchor),
            closeButton.trailingAnchor.constraint(equalTo: sketchImage.trailingAnchor)
        ])
    }
    
    @objc private func closeInstructionVC() {
        dismiss(animated: true)
    }
}
