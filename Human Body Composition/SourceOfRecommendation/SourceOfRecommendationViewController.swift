//
//  SourceOfRecommendationViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 20.07.2022.
//

import UIKit

class SourceOfRecommendationViewController: UIViewController {
/// Текст заголовка
    let firstHeaderText = "ИСТОЧНИК ИНТЕРПРЕТАЦИИ"
    /// Текст со ссылкой на источник интерпретации
    let instrumentForMeasureInstructionText = """
     Интерпретация результатов даётся в соответствии с классификацией относительного содержания жира в организме мужчин и женщин для общей популяции изложенной в монографии: Мартиросов Э.Г.
Технологии и методы определения состава тела человека / Э.Г. Мартиросов, Д.В. Николаев, С.Г. Руднев. — М.: Наука, 2006. — 248 c. — ISBN 5-02-035624-7 (в пер.). Страница 75.
Ссылка на монографию: https://www.inm.ras.ru/wp-content/uploads/library/Monographies/book2006.pdf
"""

    // MARK: - UIButtons
    /// Кнопка закрывающая экран
    private lazy var closeButton: CustomButton = {
        let button = CustomButton(title: "Понятно")
        button.addTarget(self, action: #selector(closeInstructionVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UILabels
    
    private lazy var firstHeaderLabel: CustomLabel = {
        let label = CustomLabel(text: firstHeaderText)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - UITextViews
    
    private lazy var textViewForSourceLink: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.text = instrumentForMeasureInstructionText
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = MyCustomColors.bgColorForTF.associatedColor
        textView.layer.cornerRadius = 10
        textView.dataDetectorTypes = .all
        return textView
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
        scrollView.addSubview(containerView)
        containerView.addSubview(firstHeaderLabel)
        containerView.addSubview(textViewForSourceLink)
        containerView.addSubview(closeButton)
        view.backgroundColor = MyCustomColors.bgColorForView.associatedColor
        containerView.backgroundColor = MyCustomColors.bgColorForView.associatedColor
        scrollView.backgroundColor = MyCustomColors.bgColorForView.associatedColor
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
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        firstHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        textViewForSourceLink.translatesAutoresizingMaskIntoConstraints = false
      
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
            
            textViewForSourceLink.topAnchor.constraint(equalTo: firstHeaderLabel.bottomAnchor, constant: 16),
            textViewForSourceLink.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textViewForSourceLink.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            closeButton.topAnchor.constraint(equalTo: textViewForSourceLink.bottomAnchor, constant: 20),
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
