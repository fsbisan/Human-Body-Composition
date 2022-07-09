//
//  User.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 26.11.2021.
//

import Foundation

enum Sex {
    /// Мужчина
    case male
    
    /// Женщина
    case female
}

class User {
    
    // MARK: Public Properties
    
    /// Пол
    var sex = Sex.male
    
    /// Возраст
    var age = 0.0
    
    /// Вес в килограммах
    var weight = 1.0
    
    /// Размер первой складки в мм
    var firstCrease = 1.0
    
    /// Размер второй складки в мм
    var secondCrease = 1.0
    
    /// Размер третьей складки в мм
    var thirdCrease = 1.0
    
    /// Относительная жировая масса тела(процент жира в организме)
    var relativeFatBodyMass: Double {
        switch self.sex {
        case .male:
            return 495/(1.109380 - 0.0008267 * sumOfCrease + 0.0000016 * pow(sumOfCrease, 2) - 0.0002574 * age) - 450
        case .female:
            return 495/(1.099421 - 0.0009929 * sumOfCrease + 0.0000023 * pow(sumOfCrease, 2) - 0.0001392 * age) - 450
        }
    }
    
    /// Сухая масса тела
    var dryBodyMass: Double {
        weight - (weight * relativeFatBodyMass) / 100
    }
    
    // MARK: Private Methods
    
    /// Сумма всех складок
    private var sumOfCrease: Double {
        firstCrease + secondCrease + thirdCrease
    }
}

