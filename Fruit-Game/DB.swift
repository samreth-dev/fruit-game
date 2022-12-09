//
//  DataController.swift
//  Fruit-Game
//
//  Created by Samreth Kem on 12/4/22.
//

import UIKit
import CoreData

class DB {
    static var shared = DB()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Fruit_Game")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        get {
            persistentContainer.viewContext
        }
    }
    
    func fetch() -> [Game]? {
        try? self.context.fetch(Game.fetchRequest())
    }
    
    func save() {
        try? context.save()
    }
    
    func newGame(level: String) -> Game {
        let context = persistentContainer.viewContext
        do {
            let game = Game(context: context)
            game.level = level
            try context.save()
            return game
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    private init() {}
}
