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
    var name = ""
    private let sex = Sex.male
    private let age = 0.0
    private var isTeen: Bool {
        age < 18 ? true : false
    }
    
    private let firstCrease = 0.0
    private let secondCrease = 0.0
    private let thirdCrease = 0.0
    
    var fatBodyMass: Double {
        switch (sex, isTeen) {
        case (let sex, true):
            let mass = getFatBodyMass(sex: sex)
            return mass
        case (.male, false):
            return 0
        case (.female, false):
            return 0
        }
    }
    
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
    
    init(){}
}
