//
//  UserInfoViewModel.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 21.05.2022.
//

import Foundation
import UIKit

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
    func getResultViewModel () -> ResultViewModelProtocol
    func textfieldTextDidChange (text: String?, typeOfValidate: TypeForValidate)
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
    
    func getResultViewModel() -> ResultViewModelProtocol {
        let user = User()
        guard let age = age, let weight = weight, let firstCrease = firstCrease,
              let secondCrease = secondCrease, let  thirdCrease = thirdCrease else {
            return ResultViewModel(user: user)
        }
       
        user.age = age
        user.sex = sex
        user.weight = weight
        user.firstCrease = firstCrease
        user.secondCrease = secondCrease
        user.thirdCrease = thirdCrease
        
        return ResultViewModel(user: user)
    }
    
    
}




