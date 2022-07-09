//
//  MeasureCellViewModel.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 09.07.2022.
//

import Foundation

protocol MeasureCellViewModelProtocol {
    func getMeasureDate() -> String
    init(measure: MeasureData)
}

class MeasureCellViewModel: MeasureCellViewModelProtocol {
    
    private let measure: MeasureData

    func getMeasureDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy г.  HH:mm"
        guard let measureDate = measure.date else { return "" }
        return dateFormatter.string(from: measureDate)
    }

    required init(measure: MeasureData) {
        self.measure = measure
    }
    
    
}
