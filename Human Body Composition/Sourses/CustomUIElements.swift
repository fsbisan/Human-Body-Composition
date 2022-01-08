//
//  CustomUIElements.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 07.01.2022.
//

import Foundation
import UIKit

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
        layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String) {
        super.init(frame: .zero)
        textAlignment = .center
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum MyCustomColors {
    
    case colorForActiveState
    case colorForUnActiveState
    case colorForRegButton
    case bgColorForTF
    case bgColorForView
    
    var associatedColor: UIColor {
        switch self {
        case .colorForActiveState: return UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1)
        case .colorForUnActiveState: return UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        case .colorForRegButton: return UIColor(red: 0.7, green: 0.3, blue: 0.3, alpha: 1)
        case .bgColorForTF: return UIColor(red: 1, green: 1, blue: 0.6, alpha: 1)
        case .bgColorForView: return UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1)
        }
    }
}
