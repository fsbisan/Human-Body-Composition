//
//  UserInfoViewModel.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 21.05.2022.
//

import Foundation
import UIKit

protocol UserInfoViewModelProtocol {
    var ageIsValid: Bool { get }
    var weightIsValid: Bool { get }
    var firstCreaseIsValid: Bool { get }
    var secondCreaseIsValid: Bool { get }
    var thirdCreaseIsValid: Bool { get }
    var allDataIsTrue: Bool { get }
    var validityDidChange: ((UserInfoViewModelProtocol) -> Void)? { get set }
    
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
    var allDataIsTrue: Bool {
        if ageIsValid, weightIsValid, firstCreaseIsValid, secondCreaseIsValid, thirdCreaseIsValid {
            return true
        }
        return false
    }
    
    let validator = Validator()
    
    var ageIsValid = false {
        didSet {
            validityDidChange?(self)
        }
    }
    var weightIsValid = false {
        didSet {
            validityDidChange?(self)
        }
    }
    var firstCreaseIsValid = false {
        didSet {
            validityDidChange?(self)
        }
    }
    var secondCreaseIsValid = false {
        didSet {
            validityDidChange?(self)
        }
    }
    var thirdCreaseIsValid = false {
        didSet {
            validityDidChange?(self)
        }
    }
    
    var validityDidChange: ((UserInfoViewModelProtocol) -> Void)?
    
    var sex = Sex.male
    var age: Double?
    var weight: Double?
    var firstCrease: Double?
    var secondCrease: Double?
    var thirdCrease: Double?
    
    func textfieldTextDidChange(text: String?, typeOfValidate: TypeForValidate) {
        let isValid = validator.validateText(text: text, typeOfValidate: typeOfValidate)
        switch typeOfValidate {
        case .age:
            ageIsValid = isValid
        case .weight:
            weightIsValid = isValid
        case .firstCrease:
            firstCreaseIsValid = isValid
        case .secondCrease:
            secondCreaseIsValid = isValid
        case .thirdCrease:
            thirdCreaseIsValid = isValid
        }
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




