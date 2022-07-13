//
//  MeasureCellViewModel.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 09.07.2022.
//

import Foundation

protocol MeasureCellViewModelProtocol {
    func getMeasureDate() -> String
    func getMeasureRelativeFatBodyMass() -> String
    func getWeight() -> String
    func getDryBodyMass() -> String
    init(measure: MeasureData)
}

final class MeasureCellViewModel: MeasureCellViewModelProtocol {
    private let measure: MeasureData
    
    func getWeight() -> String {
        return "Вес: \(String(format: "%.2f", measure.weight)) кг"
    }
    
    func getDryBodyMass() -> String {
        return "Сухая масса тела: \(String(format: "%.2f", measure.dryBodyMass)) кг"
    }
    
    func getMeasureDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy г.  HH:mm"
        guard let measureDate = measure.date else { return "" }
        return dateFormatter.string(from: measureDate)
    }

    func getMeasureRelativeFatBodyMass() -> String {
        return "Процент жира: \(String(format: "%.1f", measure.relativeFatBodyMass))"
    }
    
    required init(measure: MeasureData) {
        self.measure = measure
    }
    
}
