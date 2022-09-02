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
    var firstCreaseText: Box<String> { get }
    var secondCreaseText: Box<String> { get }
    
    var sex: Sex { get set }
    var age: Double? { get set }
    var weight: Double? { get set }
    var firstCrease: Double? { get set }
    var secondCrease: Double? { get set }
    var thirdCrease: Double? { get set }
    func segmentedControlDidChange(to segmentIndex: Int)
    func getResultViewModel () -> ResultViewModelProtocol
    func textfieldTextDidChange (text: String?, typeOfValidate: TypeForValidate)
    func getFirstCreaseInstructionViewModel () -> InstructionViewModelProtocol
    func getSecondCreaseInstructionViewModel () -> InstructionViewModelProtocol
    func getThirdCreaseInstructionViewModel () -> InstructionViewModelProtocol
}

final class UserInfoViewModel: UserInfoViewModelProtocol {
    
    var ageIsValid = Box(false)
    
    var weightIsValid = Box(false)
    
    var firstCreaseIsValid = Box(false)
    
    var secondCreaseIsValid = Box(false)
    
    var thirdCreaseIsValid = Box(false)
    
    var allDataIsValid = Box(false)
    
    var firstCreaseText = Box("складка на животе")
    
    var secondCreaseText = Box("складка на груди")
    
    let validator = Validator()
    
    var sex = Sex.male {
        didSet {
            firstCreaseText.value = sex == .male ? "складка на животе" : "складка на боку"
            secondCreaseText.value = sex == .male ? "складка груди" : "складка на трицепсе"
        }
    }
    
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
    
    func segmentedControlDidChange(to segmentIndex: Int) {
        sex = segmentIndex == 0 ? .male : .female
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
        let bodyPartForMeasurment: BodyPartForMeasurment = sex == .male ? .stomach : .hip
        return InstructionViewModel(bodyPartForMeasurment: bodyPartForMeasurment)
    }
    
    func getSecondCreaseInstructionViewModel() -> InstructionViewModelProtocol {
        let bodyPartForMeasurment: BodyPartForMeasurment = sex == .male ? .breast : .arm
        return InstructionViewModel(bodyPartForMeasurment: bodyPartForMeasurment)
    }
    
    func getThirdCreaseInstructionViewModel() -> InstructionViewModelProtocol {
        return InstructionViewModel(bodyPartForMeasurment: .leg)
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




