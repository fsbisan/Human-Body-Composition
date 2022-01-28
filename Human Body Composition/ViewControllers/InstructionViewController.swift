//
//  InstructionViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 27.01.2022.
//

import UIKit

enum InstructionTexts: String {
    case stomach = "stomachfghjgslksdjflkdsjflsdj"
    case breast  = "sklfjdslfkjsdlfjsdlfjsdlfj"
    case hip = "dsfdsfjlsdjfklsdjfklsdjfkldsjflksjfs"
    case arm = "Medved"
    case leg = "Privet"
}

class InstructionViewController: UIViewController {
    
    // MARK: Private Properties
    
    private var instructionsText: InstructionTexts!
   
    // MARK: UIButtons
    
    private lazy var closeButton: CustomButton = {
        let button = CustomButton(title: "Закрыть")
        button.addTarget(self, action: #selector(closeInstructionVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: UIImages
    
    private lazy var sketchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    // MARK: UILabels
    
    private lazy var instructionLabel: CustomLabel = {
        let label = CustomLabel(text: instructionsText.rawValue)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Override Methods
    
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
    
    // MARK: OBJC Methods
    
    private func setConstraints() {
        
        sketchImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sketchImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            sketchImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            sketchImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sketchImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: sketchImage.bottomAnchor, constant: 16),
            instructionLabel.leadingAnchor.constraint(equalTo: sketchImage.leadingAnchor),
            instructionLabel.trailingAnchor.constraint(equalTo: sketchImage.trailingAnchor)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    @objc private func closeInstructionVC() {
        dismiss(animated: true)
    }
}
