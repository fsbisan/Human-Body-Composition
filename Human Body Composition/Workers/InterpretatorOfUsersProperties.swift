//
//  InterpretatorOfUsersProperties.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 18.07.2022.
//

import Foundation

struct InterpretatorOfUsersProperties {
    
    private static var veryYoungAgeRange: Range<Double> = 10..<30
    private static var youngAgeRange: Range<Double> = 30..<40
    private static var middleAgeRange: Range<Double> = 40..<50
    private static var hightAgeRange: Range<Double> = 50..<60
    private static var oldAgeRange: Range<Double> = 60..<130
    
    private static var rangesForVeryYoungAgeMale: [Range<Double>] = [
        1..<11, 11..<14, 14..<21, 21..<24, 24..<100
    ]
    private static var rangesForYoungAgeMale: [Range<Double>] = [
        1..<12, 12..<15, 15..<22, 22..<25, 25..<100
    ]
    private static var rangesForMiddleAgeMale: [Range<Double>] = [
        1..<14, 14..<17, 17..<24, 24..<27, 27..<100
    ]
    private static var rangesForHightAgeMale: [Range<Double>] = [
        1..<15, 15..<18, 18..<25, 25..<28, 28..<100
    ]
    private static var rangesForOldAgeMale: [Range<Double>] = [
        1..<16, 16..<19, 19..<26, 26..<29, 29..<100
    ]
    
    private static var rangesForVeryYoungAgeFemale: [Range<Double>] = [
        1..<16, 16..<20, 20..<29, 29..<32, 32..<100
    ]
    private static var rangesForYoungAgeFemale: [Range<Double>] = [
        1..<17, 17..<21, 21..<30, 30..<33, 33..<100
    ]
    private static var rangesForMiddleAgeFemale: [Range<Double>] = [
        1..<18, 18..<22, 22..<31, 31..<34, 34..<100
    ]
    private static var rangesForHightAgeFemale: [Range<Double>] = [
        1..<19, 19..<23, 23..<32, 32..<34, 34..<100
    ]
    private static var rangesForOldAgeFemale: [Range<Double>] = [
        1..<20, 20..<24, 24..<33, 33..<36, 36..<100
    ]
    
    
    private var complexSetOfMaleRange = [
        veryYoungAgeRange: rangesForVeryYoungAgeMale,
        youngAgeRange: rangesForYoungAgeMale,
        middleAgeRange: rangesForMiddleAgeMale,
        hightAgeRange: rangesForHightAgeMale,
        oldAgeRange: rangesForOldAgeMale
    ]
    
    private let complexSetOfFemaleAge = [
        veryYoungAgeRange: rangesForVeryYoungAgeFemale,
        youngAgeRange: rangesForYoungAgeFemale,
        middleAgeRange: rangesForMiddleAgeFemale,
        hightAgeRange: rangesForHightAgeFemale,
        oldAgeRange: rangesForOldAgeFemale
    ]
    
    private func getIndexForInterpretation(for user: User) -> Int {
        var rangeIndex = 5
        if user.sex == .male {
            for (key, value) in complexSetOfMaleRange {
                if key.contains(user.age) {
                    for (index, range) in value.enumerated() {
                        if range.contains(user.relativeFatBodyMass) {
                            print(user.relativeFatBodyMass)
                            rangeIndex = index
                        }
                    }
                }
            }
        } else {
            for (key, value) in complexSetOfFemaleAge {
                if key.contains(user.age) {
                    for (index, range) in value.enumerated() {
                        if range.contains(user.relativeFatBodyMass) {
                            rangeIndex = index
                        }
                    }
                }
            }
        }
        return rangeIndex
    }
    
    func getInterpretationText(for user: User) -> (String) {
       let index = getIndexForInterpretation(for: user)
       
        switch index {
        case 0:
            let interpretation = user.sex == .male ? InterpretationOfResults.lowFat.rawValue : InterpretationOfResultsForWomen.lowFat.rawValue
            return interpretation
        case 1:
            let interpretation = user.sex == .male ? InterpretationOfResults.normalMin.rawValue : InterpretationOfResultsForWomen.normalMin.rawValue
            return interpretation
        case 2:
            let interpretation = user.sex == .male ? InterpretationOfResults.normalMax.rawValue : InterpretationOfResultsForWomen.normalMax.rawValue
            return interpretation
        case 3:
            let interpretation = user.sex == .male ? InterpretationOfResults.highFat.rawValue : InterpretationOfResultsForWomen.highFat.rawValue
            return interpretation
        case 4:
            let interpretation = user.sex == .male ? InterpretationOfResults.obesity.rawValue : InterpretationOfResultsForWomen.obesity.rawValue
            return interpretation
        default:
            return InterpretationOfResults.error.rawValue
        }
    }
    
    func getInterpretationColorComponents(for user: User) -> [Float] {
        let index = getIndexForInterpretation(for: user)
        
         switch index {
         case 0:
             let interpretation = user.sex == .male ? InterpretationOfResults.lowFat.associatedColorComponents : InterpretationOfResultsForWomen.lowFat.associatedColorComponents
             return interpretation
         case 1:
             let interpretation = user.sex == .male ? InterpretationOfResults.normalMin.associatedColorComponents : InterpretationOfResultsForWomen.normalMin.associatedColorComponents
             return interpretation
         case 2:
             let interpretation = user.sex == .male ? InterpretationOfResults.normalMax.associatedColorComponents : InterpretationOfResultsForWomen.normalMax.associatedColorComponents
             return interpretation
         case 3:
             let interpretation = user.sex == .male ? InterpretationOfResults.highFat.associatedColorComponents : InterpretationOfResultsForWomen.highFat.associatedColorComponents
             return interpretation
         case 4:
             let interpretation = user.sex == .male ? InterpretationOfResults.obesity.associatedColorComponents : InterpretationOfResultsForWomen.obesity.associatedColorComponents
             return interpretation
         default:
             return InterpretationOfResults.error.associatedColorComponents
         }
    }

    enum InterpretationOfResults: String {
        case obesity = "        Вероятно ожирение. Необходимо принять срочные меры по снижению веса."
        case highFat = "        В организме повышенное содержание жира. Для улучшения фигуры необходимо задуматься о сжигании жира."
        case normalMax = "      В организме нормальное содержание жира. Хорошая физическая форма, однако для получения рельефа нужно продолжать работу."
        case normalMin = "      В организме нормальное содержание жира. Вероятно, начинает проявляться рельефность."
        case lowFat = "     В организме низкое содержание жира. Очевидно, фигура очень рельефная."
        case error = "Ошибка: неизвестный результат"
        
        var associatedColorComponents: [Float] {
            switch self {
            case .obesity:
                return [255/255, 102/255, 102/255, 1]
            case .highFat:
                return [255/255, 153/255, 153/255, 1]
            case .normalMax:
                return [255/255, 150/255, 50/255, 1]
            case .normalMin:
                return [200/255, 255/255, 50/255, 1]
            case .lowFat:
                return [125/255, 255/255, 20/255, 1]
            case .error:
                return []
            }
        }
    }

    enum InterpretationOfResultsForWomen: String {
        case obesity = "    Вероятно ожирение! Необходимо принять меры по снижению веса."
        case highFat = "    В организме повышенное содержание жира. Необходимо задуматься о сжигании жира"
        case normalMax = "  В организме нормальное содержание жира, однако для получения рельефной фигуры необходимо продолжать работать."
        case normalMin = "  В организме нормальное содержание жира, отличная фигура!"
        case lowFat = "     В организме предельно низкое содержание жира. Если вы не профессиональная спортсменка необходимо задуматься о посещении врача"
        case error = "Ошибка: неизвестный результат"
        
        var associatedColorComponents: [Float] {
            switch self {
            case .obesity:
                return [255/255, 102/255, 102/255, 1]
            case .highFat:
                return [255/255, 153/255, 153/255, 1]
            case .normalMax:
                return [255/255, 150/255, 50/255, 1]
            case .normalMin:
                return [200/255, 255/255, 50/255, 1]
            case .lowFat:
                return [255/255, 102/255, 102/255, 1]
            case .error:
                return []
            }
        }
    }

}
