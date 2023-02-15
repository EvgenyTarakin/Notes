//
//  DataManager.swift
//  Notes
//
//  Created by Евгений Таракин on 06.02.2023.
//

import Foundation
import CoreData

final class DataManager: Hashable {
    
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
    
    func saveFolder(name: String, date: String, notes: [Note] = []) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Folder", in: context) else { return }
        
        let objects = Folder(entity: entity, insertInto: context)
        objects.name = name
        objects.date = date
        objects.notes = notes
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
    
    func saveNote(index: Int, name: String, date: String, text: String) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "Folder", in: context) else { return }
        
//        let objects = Folder(entity: entity, insertInto: context)
        
//        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
//        if let objects = try? context.fetch(fetchRequest) {
////            for object in objects {
////                if object == folder {
////                    folders[index].notes?.append(Note(name: name, date: date, text: text))
//            objects[index].notes?.append(Note(name: name, date: date, text: text))
////                }
////            }
//            context.insert(objects[index])
//        }
//        saveContext()
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
