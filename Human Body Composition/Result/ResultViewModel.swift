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
    var interpretationText: String { get }
    var interpretationViewBackgroundColorComponents: [Float] { get }
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
    
    private let interpreter = InterpretatorOfUsersProperties()
    
    var delegate: MeasureListViewControllerDelegate = MeasureListViewController()
    
    var topHeaderText = "ИЗМЕРЕНИЯ"
    var lowHeaderText = "ИНЕТЕРПРЕТАЦИЯ"
    
    var interpretationViewBackgroundColorComponents: [Float] {
        interpreter.getInterpretationColorComponents(for: user)
    }
    
    var interpretationText: String {
        interpreter.getInterpretationText(for: user)
    }
    
    required init (user: User, buttonVisibility: Bool) {
        self.user = user
        self.percentOfFat = "Процент жира в организме: \(String(format: "%.2f", user.relativeFatBodyMass)) %"
        self.dryBodyMass = "Сухая масса тела: \(String(format: "%.2f", user.dryBodyMass)) кг "
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
