//
//  InstructionViewModel.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.07.2022.
//

import Foundation

protocol InstructionViewModelProtocol {
    func getImageName() -> String
    func getInstructionText() -> String
    init(bodyPartForMeasurment: BodyPartForMeasurment)
}

/// Варианты картинок для инструкций
enum BodyPartForMeasurment: String {
    case arm
    case breast
    case hip
    case leg
    case stomach
    
    /// Варианты инструкций при при производстве замеров
    var associatedTextOfInstruction: String {
        switch self {
        case .arm:
            return """
                Вдоль середины задней поверхности трицепса плеча определите точку, которая располагается между верхушкой акромиального отростка (верхняя выступающая часть плеча) и нижней частью локтевого отростка (наиболее выпуклая нижняя часть локтя). Соберите кожу таким образом, чтобы складка шла вертикально (вдоль плечевой кости).
            """
        case .breast:
            return """
    Проведите виртуальную линию от передней части подмышечной складки до соска, отметьте середину этой линии. Соберите складку идущую вдоль линии (диагонально) в ее средней точке.
"""
        case .hip:
                return """
                Опустите воображаемую вертикальную линию от середины подмышки по боковой части туловища. Нащупайте гребень подвздошной кости. Определите точку пересечения воображаемой линии и гребня подвздошной кости. Соберите складку в этой точке. Направление складки: как правило, в этом месте образуется естественная складка, которая проходит от определенной нами точки до пупка, с приблизительным наклоном в 30 градусов.
                """
        case .leg:
              return """
                На передней поверхности бедра найдите среднюю точку, которая лежит между серединой паховой складки (естественная складка, которая образуется при сгибании бедра) и верхним краем надколенника. Соберите складку идущую вдоль бедра.
                """
        case .stomach:
                return """
                Отметьте точку на 3 см правее и на 1 см ниже пупка. Соберите горизонтальную складку.
                """
        }
    }
}

final class InstructionViewModel: InstructionViewModelProtocol {
    private let bodyPartForMeasurment: BodyPartForMeasurment
    
    func getImageName() -> String {
        bodyPartForMeasurment.rawValue
    }
    
    func getInstructionText() -> String {
        bodyPartForMeasurment.associatedTextOfInstruction
    }
    
    init(bodyPartForMeasurment: BodyPartForMeasurment) {
        self.bodyPartForMeasurment = bodyPartForMeasurment
    }
}
