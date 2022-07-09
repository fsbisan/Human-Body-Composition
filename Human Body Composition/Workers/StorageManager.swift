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
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Human_Body_Composition")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let viewContext: NSManagedObjectContext

    // MARK: - Core Data Saving support
    
    /// Сохранение в базу данных
    func saveContext (date: Date, relativeFatBodyMass: Double, dryBodyMass: Double, weight: Double) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "MeasureData", in: viewContext) else { return }
        guard let measureData = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? MeasureData else { return }
        measureData.date = date
        measureData.dryBodyMass = dryBodyMass
        measureData.relativeFatBodyMass = relativeFatBodyMass
        measureData.weight = weight
        saveContext()
    }
    /// Удаление данных из базы
    func delete(_ measure: MeasureData) {
        viewContext.delete(measure)
        saveContext()
    }
    
    /// Получение данных из базы
    func fetchData(completion: (Result<[MeasureData], Error>) -> Void) {
    ///  запрос к базе данных
        let context = persistentContainer.viewContext
        let fetchRequest = MeasureData.fetchRequest()
        do {
            let measureList = try context.fetch(fetchRequest)
            completion(.success(measureList))
        } catch let error {
            print("Faild to fetch data", error)
            completion(.failure(error))
        }
    }
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    /// Вспомогательный метод Core Data
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error {
                print(error)
            }
        }
    }
}
