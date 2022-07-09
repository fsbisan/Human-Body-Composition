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
    func getDateForRow(at indexPath: IndexPath) -> String
    func cellViewModel(at indexPath: IndexPath) -> MeasureCellViewModelProtocol
}

final class MeasureListViewModel: MeasureListViewModelProtocol {
    
    var measures: [MeasureData] = []
    
    func cellViewModel(at indexPath: IndexPath) -> MeasureCellViewModelProtocol {
        let measure = measures[indexPath.row]
        return MeasureCellViewModel(measure: measure)
    }
    
    func deleteMeasureForRow(at indexPath: IndexPath) {
        let measure = measures[indexPath.row]
        measures.remove(at: indexPath.row)
        StorageManager.shared.delete(measure)
    }
    
    func getDateForRow(at indexPath: IndexPath) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy г.  HH:mm"
        guard let measureDate = measures[indexPath.row].date else { return "" }
        let formatedMeasureDate = dateFormatter.string(from: measureDate)
        return formatedMeasureDate
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
