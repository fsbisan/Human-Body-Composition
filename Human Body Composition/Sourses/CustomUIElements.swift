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
        backgroundColor = ButtonColors.colorForActiveState.associatedColor
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum ButtonColors {
    
    case colorForActiveState
    case colorForUnActiveState
    case colorForRegButton
    
    var associatedColor: UIColor {
        switch self {
        case .colorForActiveState: return UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1)
        case .colorForUnActiveState: return UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        case .colorForRegButton: return UIColor(red: 0.7, green: 0.3, blue: 0.3, alpha: 1)
        }
    }
}
