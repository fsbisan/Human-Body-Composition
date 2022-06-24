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
        self.dryBodyMass = String(user.dryBodyMass)
    }

    func getInterpretation() -> String {
        let percentOfFat = user.fatBodyMass * 100 / user.weight
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
}

enum InterpretationOfResults: String {
    case obesity = "у Вас ожирение! Вам необходимо принять срочные меры по снижению веса."
    case highFat = "в Вашем организме нормальное содержание жира. Вам необходимо задуматься о сжигании жира."
    case normalMax = "в Вашем организме нормальное содержание жира. Вы в хорошей физической форме, однако для получения рельефа нужно продолжать работу."
    case normalMin = "в Вашем организме нормальное содержание жира. Вероятно, начинает проявляться рельефность."
    case lowFat = "в Вашем организме низкое содержание жира. Очевидно, у Вас рельефная фигура."
}
