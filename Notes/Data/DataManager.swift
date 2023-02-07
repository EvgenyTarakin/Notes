//
//  DataManager.swift
//  Notes
//
//  Created by Евгений Таракин on 06.02.2023.
//

import Foundation
import CoreData

class DataManager: Hashable {
    
    private let context = CoreDataManager.persistentContainer.viewContext
    
    var folders: [Folder] {
        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
        do {
            return try context.fetch(fetchRequest).reversed()
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveFolder(name: String, date: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Folder", in: context) else { return }
        
        let objects = Folder(entity: entity, insertInto: context)
        objects.name = name
        objects.date = date
        saveContext()
    }
    
    func deleteFolder(_ folder: Folder) {
        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                if object == folder {
                    context.delete(object)
                }
            }
        }
        saveContext()
    }
    
    func deleteAllFolders() {
        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    let uuid = UUID()
    static func ==(lhs: DataManager, rhs: DataManager) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
}
