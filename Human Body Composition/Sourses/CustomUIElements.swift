//
//  CustomUIElements.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 07.01.2022.
//

import Foundation
import UIKit

//MARK: - Custom UIKit Elements
/// Кнопки используемые в приложении
class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        backgroundColor = MyCustomColors.colorForActiveState.associatedColor
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setTitleColor(.black, for: .normal)
        titleLabel?.numberOfLines = 0
        layer.cornerRadius = 4
    }
    /// Свойство для передачи подробной информации при нажатии
    var instructionTextToSend = InstructionTexts.stomach
    var imageNameToSend = ""
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/// Лэйблы используемые в приложении
class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var correctText = ""
    var incorrectText = ""
    
    init(text: String) {
        super.init(frame: .zero)
        textAlignment = .center
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/// Текстовые поля используемые в приложении
class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        borderStyle = .roundedRect
        backgroundColor = MyCustomColors.bgColorForTF.associatedColor
        keyboardType = .numberPad
        layer.shadowRadius = 1
        layer.shadowColor = UIColor.blue.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Custom Atributes

/// Цвета используемые в интерфейсе
enum MyCustomColors {
    
    case colorForActiveState
    case colorForUnActiveState
    case colorForRegButton
    case bgColorForTF
    case bgColorForView
    
    var associatedColor: UIColor {
        switch self {
        case .colorForActiveState: return UIColor(red: 0.3, green: 0.6, blue: 1.0, alpha: 0.5)
        case .colorForUnActiveState: return UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        case .colorForRegButton: return UIColor(red: 255/178, green: 255/76, blue: 255/76, alpha: 1)
        case .bgColorForTF: return UIColor(red: 255/255, green: 255/255, blue: 0.6, alpha: 1)
        case .bgColorForView: return UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        }
    }
}

