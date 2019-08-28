//
//  CoreDataModule.swift
//  Dday
//
//  Created by 박성헌 on 2019. 8. 28..
//  Copyright © 2019년 n30gu1. All rights reserved.
//

import Foundation
import CoreData

class CoreDataModule {
    static let shared = CoreDataModule()
    private init() {}
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var ddayList = [Dday]()
    
    func fetchDday() {
        let request: NSFetchRequest<Dday> = Dday.fetchRequest()
        do {
            ddayList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func addNewDday(_ title: String?, _ date: Date?) {
        let newDday = Dday(context: mainContext)
        newDday.title = title
        newDday.date = date
        
        saveContext()
    }
    
    func deleteDday(_ dday: Dday?) {
        if let dday = dday {
            mainContext.delete(dday)
            saveContext()
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Dday")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
