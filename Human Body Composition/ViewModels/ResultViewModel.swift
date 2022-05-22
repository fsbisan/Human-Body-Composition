//
//  ResultViewModelProtocol.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 12.05.2022.
//

import Foundation

protocol ResultViewModelProtocol {
    var percentOfFat: String { get }
    var dryBodyMass: String { get }
    func getInterpretation() -> String
    init (user: User)
}

class ResultViewModel: ResultViewModelProtocol {
    
    private var user: User
    let percentOfFat: String
    let dryBodyMass: String
    
    required init (user: User) {
        self.user = user
        self.percentOfFat = String(user.fatBodyMass)
        self.dryBodyMass = String(user.fatBodyMass)
    }

    func getInterpretation() -> String {
        let fatBodyMass = getFatBodyMass(from: user)
        let percentOfFat = fatBodyMass * 100 / user.weight
        switch percentOfFat {
        case 1..<4:
            return InterpretationOfResults.lowFat.rawValue
        case 4..<10:
            return InterpretationOfResults.normalMin.rawValue
        case 10..<20:
            return InterpretationOfResults.normalMax.rawValue
        case 20..<26:
            return InterpretationOfResults.highFat.rawValue
        case 26...100:
            return InterpretationOfResults.obesity.rawValue
        default:
            return "Ошибка: неизвестный результат"
        }
    }

    private func getFatBodyMass(from user: User) -> Double {
        switch user.sex {
        case .male:
            let fatBodyMass: Double = 495/(1.109380 - 0.0008267 * user.sumOfCrease + 0.0000016 * pow(user.sumOfCrease, 2) - 0.0002574 * user.age) - 450
            return fatBodyMass
        case .female:
            let fatBodyMass: Double = 495/(1.099421 - 0.0009929 * user.sumOfCrease + 0.0000023 * pow(user.sumOfCrease, 2) - 0.0001392 * user.age) - 450
            return fatBodyMass
        }
    }
}

enum InterpretationOfResults: String {
    case obesity = "у Вас ожирение! Вам необходимо принять срочные меры по снижению веса."
    case highFat = "в Вашем организме нормальное содержание жира. Вам необходимо задуматься о сжигании жира."
    case normalMax = "в Вашем организме нормальное содержание жира. Вы в хорошей физической форме, однако для получения рельефа нужно продолжать работу."
    case normalMin = "в Вашем организме нормальное содержание жира. Вероятно, начинает проявляться рельефность."
    case lowFat = "в Вашем организме низкое содержание жира. Очевидно, у Вас рельефная фигура."
}
