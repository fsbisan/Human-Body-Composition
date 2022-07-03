//
//  StorageManager.swift
//  Human Body Composition
//
//  Created by Александр Макаров on 03.07.2022.
//

import Foundation
import CoreData

final class StorageManager {
    static var shared = StorageManager()
    
    // MARK: - Core Data stack

    // Выход в базу данных
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Human_Body_Composition")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    
    /// Сохранение в базу данных
    func saveContext (date: Date, relativeFatBodyMass: Double, dryBodyMass: Double, weight: Double) {
        let context = persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "MeasureData", in: context) else { return }
        guard let measureData = NSManagedObject(entity: entityDescription, insertInto: context) as? MeasureData else { return }
        measureData.date = date
        measureData.dryBodyMass = dryBodyMass
        measureData.relativeFatBodyMass = relativeFatBodyMass
        measureData.weight = weight
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
    }
    /// Получение данных из базы
    func fetchData() -> [MeasureData] {
    ///  запрос к базе данных
        let context = persistentContainer.viewContext
        let fetchRequest = MeasureData.fetchRequest()
        do {
            let measureList = try context.fetch(fetchRequest)
            return measureList
        } catch let error {
            print("Faild to fetch data", error)
            return []
        }
    }
    
    init() {}
}
