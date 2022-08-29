//
//  InstructionViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 27.01.2022.
//

import UIKit


/// Отображает экран с инструкцией
final class InstructionViewController: UIViewController {
    
    // MARK: - Private Properties
    var instructionViewModel: InstructionViewModelProtocol! {
        didSet {
            instructionImage.image = UIImage(named: instructionViewModel.getImageName())
            instructionLabel.text = instructionViewModel.getInstructionText()
        }
    }
    
    // MARK: - UIButtons
    
    private lazy var closeButton: CustomButton = {
        let button = CustomButton(title: "Понятно")
        button.addTarget(self, action: #selector(closeInstructionVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UIImages
    
    private lazy var instructionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - UILabels
    
    private lazy var instructionLabel: CustomLabel = {
        let label = CustomLabel(text: "")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - UIScrollViews
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    // MARK: - UIView
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(instructionImage)
        containerView.addSubview(instructionLabel)
        containerView.addSubview(closeButton)
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
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        instructionImage.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
  
            instructionImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            instructionImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor ,constant: -16),
            instructionImage.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 16),
            instructionImage.heightAnchor.constraint(equalTo: instructionImage.widthAnchor, multiplier: 3 / 2),

            instructionLabel.topAnchor.constraint(equalTo: instructionImage.bottomAnchor, constant: 16),
            instructionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            instructionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            closeButton.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func closeInstructionVC() {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        instructionImage.layer.cornerRadius = 10
        instructionImage.clipsToBounds = true
    }
}
