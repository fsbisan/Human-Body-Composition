//
//  MesureListViewModel.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.07.2022.
//

import Foundation

protocol MeasureListViewModelProtocol {
    var measures: [MeasureData] { get }
    func fetchMeasures(completion: () -> Void)
    func numberOfRows() -> Int
    func deleteMeasureForRow(at indexPath: IndexPath)
    func cellViewModel(at indexPath: IndexPath) -> MeasureCellViewModelProtocol
    func getResultViewModel(at indexPath: IndexPath) -> ResultViewModelProtocol
}

final class MeasureListViewModel: MeasureListViewModelProtocol {
    
    var measures: [MeasureData] = []
    
    func getResultViewModel(at indexPath: IndexPath) -> ResultViewModelProtocol {
        let measure = measures[indexPath.row]
        guard let sex = measure.sex
        else {
            print("неизвлекся пол")
            return ResultViewModel(user: User(), buttonVisibility: false)
        }
        let user = User(sex: sex, age: measure.age, weight: measure.weight, firstCrease: measure.firstCrease, secondCrease: measure.secondCrease, thirdCrease: measure.thirdCrease)
        return ResultViewModel(user: user, buttonVisibility: false)
    }
    
    func cellViewModel(at indexPath: IndexPath) -> MeasureCellViewModelProtocol {
        let measure = measures[indexPath.row]
        return MeasureCellViewModel(measure: measure)
    }
    
    func deleteMeasureForRow(at indexPath: IndexPath) {
        let measure = measures[indexPath.row]
        measures.remove(at: indexPath.row)
        StorageManager.shared.delete(measure)
    }
    
    func fetchMeasures(completion: () -> Void) {
        StorageManager.shared.fetchData { [unowned self] result in
            switch result {
            case .success(let measures):
                self.measures = measures
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        measures.count
    }
}
