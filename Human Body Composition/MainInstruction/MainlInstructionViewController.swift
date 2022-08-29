//
//  MainInstructionViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 14.07.2022.
//

import UIKit

class MainlInstructionViewController: UIViewController {
    let firstHeaderText = "Инструменты для измерения толщины жировых складок"
    let secondHeaderText = "Правила измерения"
    
    let instrumentForMeasureInstructionText = "     Для того, чтобы рассчитать процент жира в организме, вам понадобится калипер. Но можно использовать и обычную линейку, для этого ее нужно приложить к складке, сместив на пару сантиметров к основанию."
    
    let rulesForMeasureText = """
* Выполняйте все измерения стоя.

* Выполняйте измерения на правой стороне тела.

* Собирайте складку большим и указательным пальцем. Захватывайте кожу достаточно широко, так что бы жировая прослойка была сложена в двое между вашими пальцами. Сжимайте складку достаточно сильно (легкие болевые ощущения), для того, что бы изгнать воду из жировой ткани, но не держите дольше 5 секунд, иначе результат будет неточным.

* Накладывайте линейку или калипер на 2 см в сторону от ваших пальцев (между пиком и основанием складки).

* Для повышения точности расчета процента жира в организме выполните 2-3 измерения, однако не выполняйте сразу 3 измерения подряд в одном месте. Вы должны чередовать указанные ниже места попеременно: трицепс - живот - бедро - трицепс и так далее.

* Что бы максимально увеличить точность процента жира в организме, попросите выполнить измерения близкого человека и сравните со своими. Вводите в систему усредненные результаты.

* Нужно помнить, что спустя время, повторные измерения должны снимать те же люди, что делали это в предыдущий раз.
"""
    // MARK: - UIButtons
    
    private lazy var closeButton: CustomButton = {
        let button = CustomButton(title: "Понятно")
        button.addTarget(self, action: #selector(closeInstructionVC), for: .touchUpInside)
        return button
    }()
  
    // MARK: - UIImages
    
    private lazy var instructionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "crease")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - UILabels
    
    private lazy var firstHeaderLabel: CustomLabel = {
        let label = CustomLabel(text: firstHeaderText)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var secondHeaderLabel: CustomLabel = {
        let label = CustomLabel(text: secondHeaderText)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var instrumentForMeasureLabel: CustomLabel = {
        let label = CustomLabel(text: instrumentForMeasureInstructionText)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var rulesOfMeasureLabel: CustomLabel = {
        let label = CustomLabel(text: rulesForMeasureText)
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
        setupSubviews(scrollView)
        view.backgroundColor = .white
        scrollView.addSubview(containerView)
        containerView.addSubview(firstHeaderLabel)
        containerView.addSubview(instrumentForMeasureLabel)
        containerView.addSubview(secondHeaderLabel)
        containerView.addSubview(rulesOfMeasureLabel)
        containerView.addSubview(instructionImage)
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
        rulesOfMeasureLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        firstHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        secondHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        instrumentForMeasureLabel.translatesAutoresizingMaskIntoConstraints = false
        rulesOfMeasureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
  
            firstHeaderLabel.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 16),
            firstHeaderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            firstHeaderLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            instrumentForMeasureLabel.topAnchor.constraint(equalTo: firstHeaderLabel.bottomAnchor, constant: 16),
            instrumentForMeasureLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            instrumentForMeasureLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            secondHeaderLabel.topAnchor.constraint(equalTo: instrumentForMeasureLabel.bottomAnchor, constant: 20),
            secondHeaderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            secondHeaderLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            instructionImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            instructionImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor ,constant: -16),
            instructionImage.topAnchor.constraint(equalTo: secondHeaderLabel.bottomAnchor, constant: 16),
            instructionImage.heightAnchor.constraint(equalTo: instructionImage.widthAnchor, multiplier: 3 / 2),

            rulesOfMeasureLabel.topAnchor.constraint(equalTo: instructionImage.bottomAnchor, constant: 16),
            rulesOfMeasureLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            rulesOfMeasureLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            closeButton.topAnchor.constraint(equalTo: rulesOfMeasureLabel.bottomAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func closeInstructionVC() {
        dismiss(animated: true)
    }
}
