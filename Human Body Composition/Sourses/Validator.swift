//
//  Validator.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 12.06.2022.
//

import Foundation
enum TypeForValidate {
    case age
    case weight
    case firstCrease
    case secondCrease
    case thirdCrease
}

class Validator {
    func validateText(text: String?, typeOfValidate: TypeForValidate) -> Bool {
        guard let text = text else { return false }
        var rangeOfValidate: [Double] = []
        switch typeOfValidate {
        case .age:
            rangeOfValidate = [10, 150]
        case .weight:
            rangeOfValidate = [40, 200]
        case .firstCrease:
            rangeOfValidate = [2, 60]
        case .secondCrease:
            rangeOfValidate = [2, 60]
        case .thirdCrease:
            rangeOfValidate = [2, 60]
        }
        
        if let validatingNumber = Double(text) {
            if rangeOfValidate[0]...rangeOfValidate[1] ~= validatingNumber {
                return true
            }
        }
        return false
    }
}


