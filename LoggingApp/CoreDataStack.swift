//
//  CoreDataStack.swift
//  LoggingApp
//
//  Created by Geart Otten on 12/12/2019.
//  Copyright © 2019 Geart Otten. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let instance = CoreDataStack()
    
    lazy var applicationDocumentsDirectory: URL = {
        
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.go.loggingapp")
        
        //        let url = urls[urls.count-1]
        print("Connecting to SQLite-database at \(url!)")
        return url!
    }()
    
    
    // MARK moeten we zelf een NSManagedObjectModel maken?!?!?
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "WSP", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("loggingsapp.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    // MARK: - First time launch
    var aircraftTypes: [String] = ["F-16", "Alouette III", "Cirrus SR22"]
    var aircraftSerialNumbers: [String] = ["J-234", "A-319", "SR22-2889"]
    // MARK: - Core Data Saving support
    
    var fetchedAircrafts = [AircraftMO]()
    
    func storeQuestions(){
        
    }
    
    func storeWSP(withQuestions step: StepMO) {
        
    }
//    var fetchedFriends = [Friend]()
//
//    func storeGifts(withTitle title:String, withText text:String, withFriend friend:Friend){
//        let gift = Gift(context: managedObjectContext)
//        gift.note = text
//        gift.title = title
//        storeFriend(withGift: gift, withFriend: friend)
//    }
//
//    func storeFriend(withGift gift:Gift, withFriend friend:Friend){
//        friend.addToGift(gift)
//        CoreDataStack.instance.saveContext()
//        fetchFriend()
//    }

    func fetchAircrafts(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Aircraft")
        
        do {
            self.fetchedAircrafts = try managedObjectContext.fetch(fetchRequest) as! [AircraftMO]
            if self.fetchedAircrafts.isEmpty {
                for (index, aircraftType) in aircraftTypes.enumerated() {
                    let aircraft = AircraftMO(context: self.managedObjectContext)
                    aircraft.serialnumber = aircraftSerialNumbers[index]
                    aircraft.type = aircraftType
                    saveContext()
                }
                self.fetchAircrafts()
            }
        } catch {
            print(error)
        }
        
    }
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}

