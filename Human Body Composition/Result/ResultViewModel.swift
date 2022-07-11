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
    var topViewBackgroundColor: UIColor { get }
    var divisionViewBackgroundColor: UIColor { get }
    var interpretationViewBackgroundColor: UIColor { get }
    var interpretationOfResults: InterpretationOfResults { get }
    var topHeaderText: String { get }
    var lowHeaderText: String { get }
    var buttonVisibility: Bool { get }
    func getDate() -> String
    func saveButtonDidTapped()
    func deleteButtonTapped(measure: MeasureData)
    func getSex() -> String
    func getAge() -> String
    func getWeight() -> String
    func getFirstCreaseSize() -> String
    func getSecondCreaseSize() -> String
    func getThirdCreaseSize() -> String
    init (user: User, buttonVisibility: Bool)
}

class ResultViewModel: ResultViewModelProtocol {
    
    
    private var user: User
    
    let percentOfFat: String
    let dryBodyMass: String
    var buttonVisibility: Bool
    
    var interpretationOfResults: InterpretationOfResults {
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
    
    var delegate: MeasureListViewControllerDelegate = MeasureListViewController()
    
    var topHeaderText = "ИЗМЕРЕНИЯ"
    var lowHeaderText = "ИНЕТЕРПРЕТАЦИЯ"
    
    let divisionViewBackgroundColor: UIColor = .black
    let topViewBackgroundColor: UIColor = MyCustomColors.bgColorForTF.associatedColor
    
    var interpretationViewBackgroundColor: UIColor {
        interpretationOfResults.associatedColor
    }
    
    required init (user: User, buttonVisibility: Bool) {
        self.user = user
        self.percentOfFat = "Процент жира в организме: \(String(format: "%.1f", user.relativeFatBodyMass)) %"
        self.dryBodyMass = "Сухая масса тела: \(String(format: "%.1f", user.dryBodyMass)) кг "
        self.buttonVisibility = buttonVisibility
    }
    
    func setDateOfMeasure() {
        user.dateOfMeasure = Date()
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy г.  HH:mm"
        return dateFormatter.string(from: user.dateOfMeasure )
    }
    
    func saveButtonDidTapped() {
        StorageManager.shared.saveContext(date: user.dateOfMeasure , age: user.age, sex: user.sex.rawValue, firstCrease: user.firstCrease, secondCrease: user.secondCrease, thirdCrease: user.thirdCrease, relativeFatBodyMass: user.relativeFatBodyMass, dryBodyMass: user.dryBodyMass, weight: user.weight)
        delegate.upDateMeasureListViewModel()
    }
    
    func deleteButtonTapped(measure: MeasureData) {
        StorageManager.shared.delete(measure)
    }
    
    func getSex() -> String {
        return "Пол: \(user.sex.associatedValue)"
    }
    
    func getWeight() -> String {
        return "Вес: \(String(format: "%.1f", user.weight)) кг"
    }
    
    func getFirstCreaseSize() -> String {
        switch user.sex {
        case .male:
            return "Складка на животе: \(String(format: "%.0f", user.firstCrease)) мм"
        case .female:
            return "Складка на боку: \(String(format: "%.0f", user.firstCrease)) мм"
        }
    }
    
    func getSecondCreaseSize() -> String {
        switch user.sex {
        case .male:
            return "Складка на груди: \(String(format: "%.0f", user.secondCrease)) мм"
        case .female:
            return "Складка на трицепсе: \(String(format: "%.0f", user.secondCrease)) мм"
        }
       
    }
    
    func getThirdCreaseSize() -> String {
        return "Складка на бедре: \(String(format: "%.0f", user.thirdCrease)) мм"
    }
    
    func getAge() -> String {
        return "Возраст: \(String(format: "%.0f", user.age)) лет"
    }
}

enum InterpretationOfResults: String {
    case obesity = "    У Вас ожирение! Вам необходимо принять срочные меры по снижению веса."
    case highFat = "    В Вашем организме нормальное содержание жира. Вам необходимо задуматься о сжигании жира."
    case normalMax = "  В Вашем организме нормальное содержание жира. Вы в хорошей физической форме, однако для получения рельефа нужно продолжать работу."
    case normalMin = "  В Вашем организме нормальное содержание жира. Вероятно, начинает проявляться рельефность."
    case lowFat = " В Вашем организме низкое содержание жира. Очевидно, у Вас очень рельефная фигура."
    case error = "Ошибка: неизвестный результат"
    
    var associatedColor: UIColor {
        switch self {
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
}
