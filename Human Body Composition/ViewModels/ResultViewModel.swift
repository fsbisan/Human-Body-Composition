//
//  ResultViewModelProtocol.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 12.05.2022.
//

import Foundation
import UIKit

protocol ResultViewModelProtocol {
    var percentOfFat: String { get }
    var dryBodyMass: String { get }
    func getInterpretation() -> String
    func getDate() -> String
    func getInterpretationBackGroundColor() -> UIColor
    init (user: User)
}

class ResultViewModel: ResultViewModelProtocol {
    
    private var user: User
    let percentOfFat: String
    let dryBodyMass: String
    private var interpretationOfResults: InterpretationOfResults {
        switch user.relativeFatBodyMass {
        case 1..<4:
            return InterpretationOfResults.lowFat
        case 4..<10:
            return InterpretationOfResults.normalMin
        case 10..<20:
            return InterpretationOfResults.normalMax
        case 20..<26:
            return InterpretationOfResults.highFat
        case 26...100:
            return InterpretationOfResults.obesity
        default:
            return InterpretationOfResults.error
        }
    }
    
    required init (user: User) {
        self.user = user
        self.percentOfFat = "Процент жира в организме: " + String(format: "%.1f", user.relativeFatBodyMass)
        self.dryBodyMass = "Сухая масса тела: " + String(format: "%.1f", user.dryBodyMass)
    }

    func getInterpretation() -> String {
        interpretationOfResults.rawValue
    }
    
    func getInterpretationBackGroundColor() -> UIColor {
        switch interpretationOfResults {
        case .obesity:
            return UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        case .highFat:
           return UIColor(red: 1, green: 0.6, blue: 0.6, alpha: 1)
        case .normalMax:
            return UIColor(red: 255/255, green: 150/255, blue: 50/255, alpha: 1)
        case .normalMin:
            return UIColor(red: 200/255, green: 255/255, blue: 50/255, alpha: 1)
        case .lowFat:
            return UIColor(red: 125/255, green: 255/255, blue: 20/255, alpha: 1)
        case .error:
            return UIColor(red: 1, green: 0.6, blue: 0.6, alpha: 1)
        }
    }
    
    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy г.  HH:mm"
        return dateFormatter.string(from: date)
    }
}

enum InterpretationOfResults: String {
    case obesity = "У Вас ожирение! Вам необходимо принять срочные меры по снижению веса."
    case highFat = "В Вашем организме нормальное содержание жира. Вам необходимо задуматься о сжигании жира."
    case normalMax = "В Вашем организме нормальное содержание жира. Вы в хорошей физической форме, однако для получения рельефа нужно продолжать работу."
    case normalMin = "В Вашем организме нормальное содержание жира. Вероятно, начинает проявляться рельефность."
    case lowFat = "В Вашем организме низкое содержание жира. Очевидно, у Вас очень рельефная фигура."
    case error = "Ошибка: неизвестный результат"
}
