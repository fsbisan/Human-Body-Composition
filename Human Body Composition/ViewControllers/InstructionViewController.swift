//
//  InstructionViewController.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 27.01.2022.
//

import UIKit

enum InstructionTexts: String {
    case stomach = """
    Отметьте точку на 3 см правее и на 1 см ниже пупка. Соберите горизонтальную \
    складку.
    """
    case breast  = """
    Проведите виртуальную линию от передней части подмышечной складки до соска, \
    отметьте середину этой линии. Соберите складку идущую вдоль линии (диагонально) \
    в ее средней точке.
    """
    case hip = """
    Опустите воображаемую вертикальную линию от середины подмышки по боковой \
    части туловища. Нащупайте гребень подвздошной кости. Определите точку \
    пересечения воображаемой линии и гребня подвздошной кости. Соберите складку \
    в этой точке. Направление складки: как правило, в этом месте образуется \
    естественная складка, которая проходит от определенной нами точки до пупка, \
    с приблизительным наклоном в 30 градусов.
    """
    case arm = """
    Вдоль середины задней поверхности трицепса плеча определите \
    точку,которая располагается между верхушкой акромиального отростка \
    (верхняя выступающая часть плеча) и нижней частью локтевого отростка \
    (наиболее выпуклая нижняя часть локтя). Соберите кожу таким образом, \
    чтобы складка шла вертикально (вдоль плечевой кости).
    """
    case leg = """
    На передней поверхности бедра найдите среднюю точку, которая лежит между \
    серединой паховой складки (естественная складка, которая образуется при \
    сгибании бедра) и верхним краем надколенника. Соберите складку идущую вдоль \
    бедра.
    """
}

enum ImageNames: String {
    case armImage
    case breastImage
    case hipImage
    case legImage
    case stomachImage
}

class InstructionViewController: UIViewController {
    
    // MARK: - Private Properties
    
    var instructionsText: InstructionTexts!
    var imageName: String!
   
    // MARK: - UIButtons
    
    private lazy var closeButton: CustomButton = {
        let button = CustomButton(title: "Закрыть")
        button.addTarget(self, action: #selector(closeInstructionVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UIImages
    
    private lazy var sketchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        return imageView
    }()
    
    // MARK: - UILabels
    
    private lazy var instructionLabel: CustomLabel = {
        let label = CustomLabel(text: instructionsText.rawValue)
        label.textAlignment = .justified
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
            sketchImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            sketchImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
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
