//
//  UserInfoViewModel.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 21.05.2022.
//

import Foundation

protocol UserInfoViewModelProtocol {
    
    var ageIsValid: Box<Bool> { get }
    var weightIsValid: Box<Bool> { get }
    var firstCreaseIsValid: Box<Bool> { get }
    var secondCreaseIsValid: Box<Bool> { get }
    var thirdCreaseIsValid: Box<Bool> { get }
    var allDataIsValid: Box<Bool> { get }
    
    var sex: Sex { get set }
    var age: Double? { get set }
    var weight: Double? { get set }
    var firstCrease: Double? { get set }
    var secondCrease: Double? { get set }
    var thirdCrease: Double? { get set }
    func pressedSegment(at segmentedIndex: Int)
    func getFirstCreaseLabelText() -> String
    func getSecondCreaseLabelText() -> String
    func getResultViewModel () -> ResultViewModelProtocol
    func textfieldTextDidChange (text: String?, typeOfValidate: TypeForValidate)
    func getFirstCreaseInstructionViewModel () -> InstructionViewModelProtocol
    func getSecondCreaseInstructionViewModel () -> InstructionViewModelProtocol
    func getThirdCreaseInstructionViewModel () -> InstructionViewModelProtocol
}

class UserInfoViewModel: UserInfoViewModelProtocol {
    
   
    var ageIsValid = Box(false)
    
    var weightIsValid = Box(false)
    
    var firstCreaseIsValid = Box(false)
    
    var secondCreaseIsValid = Box(false)
    
    var thirdCreaseIsValid = Box(false)
    
    var allDataIsValid = Box(false)
    
    let validator = Validator()
    
    var sex = Sex.male
    var age: Double?
    var weight: Double?
    var firstCrease: Double?
    var secondCrease: Double?
    var thirdCrease: Double?
    
    private func getValidityOfAllData() {
        if ageIsValid.value, weightIsValid.value, firstCreaseIsValid.value, secondCreaseIsValid.value, thirdCreaseIsValid.value {
            allDataIsValid.value = true
        } else { allDataIsValid.value = false}
    }
    
    func getFirstCreaseLabelText() -> String {
        <#code#>
    }
    
    func textfieldTextDidChange(text: String?, typeOfValidate: TypeForValidate) {
        guard let text = text else { return }
        let isValid = validator.validateText(text: text, typeOfValidate: typeOfValidate)
        switch typeOfValidate {
        case .age:
            ageIsValid.value = isValid
            age = Double(text)
        case .weight:
            weightIsValid.value = isValid
            weight = Double(text)
        case .firstCrease:
            firstCreaseIsValid.value = isValid
            firstCrease = Double(text)
        case .secondCrease:
            secondCreaseIsValid.value = isValid
            secondCrease = Double(text)
        case .thirdCrease:
            thirdCreaseIsValid.value = isValid
            thirdCrease = Double(text)
        }
        getValidityOfAllData()

    }
    
    func getFirstCreaseInstructionViewModel() -> InstructionViewModelProtocol {
        switch sex {
        case .male:
            return InstructionViewModel(partForMeasurment: .stomach)
        case .female:
            return InstructionViewModel(partForMeasurment: .hip)
        }
    }
    
    func getSecondCreaseInstructionViewModel() -> InstructionViewModelProtocol {
        switch sex {
        case .male:
            return InstructionViewModel(partForMeasurment: .breast)
        case .female:
            return InstructionViewModel(partForMeasurment: .arm)
        }
    }
    
    func getThirdCreaseInstructionViewModel() -> InstructionViewModelProtocol {
        return InstructionViewModel(partForMeasurment: .leg)
    }
    
    func getResultViewModel() -> ResultViewModelProtocol {
        guard let age = age, let weight = weight, let firstCrease = firstCrease,
              let secondCrease = secondCrease, let  thirdCrease = thirdCrease else {
            return ResultViewModel(user: User(), buttonVisibility: true)
        }
       
        let user = User(sex: sex.rawValue, age: age, weight: weight, firstCrease: firstCrease, secondCrease: secondCrease, thirdCrease: thirdCrease, dateOfMeasure: Date())

        return ResultViewModel(user: user, buttonVisibility: true)
    }
    
    
}




