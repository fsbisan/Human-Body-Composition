//
//  User.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 26.11.2021.
//

import Foundation

enum Sex {
    case male
    case female
}

class User {
    
    // MARK: Public Properties
    
    var name = ""
    var sex = Sex.male
    var age = 0.0
    var weight = 1.0
    
    var firstCrease = 1.0
    var secondCrease = 1.0
    var thirdCrease = 1.0
    
    private var isTeen: Bool {
        age < 18 ? true : false
    }
    
    var fatBodyMass: Double {
        switch (sex, isTeen) {
        case (.male, true):
            let mass = getFatBodyMass(sex: sex)
            return mass
        case (.male, false):
            let mass = getFatBodyMass(sex: sex)
            return mass
        case (.female, false):
            let mass = getFatBodyMass(sex: sex)
            return mass
        case (.female, true):
            let mass = getFatBodyMass(sex: sex)
            return mass
        }
    }
    
    // MARK: Private Methods
    
    private var sumOfCrease: Double {
        firstCrease + secondCrease + thirdCrease
    }
    
    private func getFatBodyMass(sex: Sex) -> Double {
        switch sex {
        case .male:
            let fatBodyMass: Double = 495/(1.109380 - 0.0008267 * sumOfCrease + 0.0000016 * pow(sumOfCrease, 2) - 0.0002574 * age) - 450
            return fatBodyMass
        case .female:
            let fatBodyMass: Double = 495/(1.099421 - 0.0009929 * sumOfCrease + 0.0000023 * pow(sumOfCrease, 2) - 0.0001392 * age) - 450
            return fatBodyMass
            
        }
    }
}

