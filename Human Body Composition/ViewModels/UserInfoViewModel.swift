//
//  UserInfoViewModel.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 21.05.2022.
//

import Foundation

protocol UserInfoViewModelProtocol {
    var ageIsValid: Bool { get }
    var weightIsValid: Bool { get }
    var firstCreaseIsValid: Bool { get }
    var secondCreaseIsValid: Bool { get }
    var thirdCreaseIsValid: Bool { get }
    
    var sex: Sex { get set }
    var age: Double? { get set }
    var weight: Double? { get set }
    var firstCrease: Double? { get set }
    var secondCrease: Double? { get set }
    var thirdCrease: Double? { get set }
    func getResultViewModel () -> ResultViewModelProtocol
}

class UserInfoViewModel: UserInfoViewModelProtocol {
    
    var ageIsValid = false
    var weightIsValid = false
    var firstCreaseIsValid = false
    var secondCreaseIsValid = false
    var thirdCreaseIsValid = false
    
    var sex = Sex.male
    var age: Double?
    var weight: Double?
    var firstCrease: Double?
    var secondCrease: Double?
    var thirdCrease: Double?
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
