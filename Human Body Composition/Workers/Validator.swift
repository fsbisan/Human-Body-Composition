//
//  Validator.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 12.06.2022.
//

import Foundation

/// Типы валидируемых данных
enum TypeForValidate {
    case age
    case weight
    case firstCrease
    case secondCrease
    case thirdCrease
}
/// Валидирует значения согласно переданного типа
struct Validator {
    func validateText(text: String, typeOfValidate: TypeForValidate) -> Bool {
        var rangeOfValidate: [Double] = []
        /// Задание диапазона валидации в зависимости от типа
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
        /// Проверка на вхождение входных данных в допустимый диапазон
        if let validatingNumber = Double(text) {
            if rangeOfValidate[0]...rangeOfValidate[1] ~= validatingNumber {
                return true
            }
        }
        return false
    }
}


