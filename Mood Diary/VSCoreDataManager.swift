//
//  VSCoreDataManager.swift
//  Mood Diary
//
//  Created by Vikas Shah on 5/16/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import CoreData
import Foundation

private let kSQLiteFileName = "VSMood_Diary.sqlite"
private let kModelFileName = "Mood_Diary"

class VSCoreDataManager: NSObject {
    static let sharedManager = VSCoreDataManager()
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.vikas.Mood_Diary" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource(kModelFileName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(kSQLiteFileName)
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "VS_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var rootSavingContext: NSManagedObjectContext = {
        // Returns the managed object context used for saving application data to the persistence store
        let coordinator = self.persistentStoreCoordinator
        var rootSavingContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        rootSavingContext.persistentStoreCoordinator = coordinator
        return rootSavingContext
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        var mainContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        mainContext.parentContext = self.rootSavingContext
        mainContext.persistentStoreCoordinator = mainContext.parentContext?.persistentStoreCoordinator
        
        NSNotificationCenter.defaultCenter().addObserverForName(NSManagedObjectContextDidSaveNotification,
                                                                object: mainContext.parentContext,
                                                                queue: NSOperationQueue.mainQueue(),
                                                                usingBlock: { notification in
                                                                    guard let userInfo  = notification.userInfo,
                                                                        let updatedObjects = userInfo[NSUpdatedObjectsKey] as? [NSManagedObject] else {
                                                                            return
                                                                    }
                                                                    
                                                                    for object in updatedObjects {
                                                                        mainContext.objectWithID(object.objectID).willAccessValueForKey(nil)
                                                                    }
                                                                    
                                                                    mainContext.mergeChangesFromContextDidSaveNotification(notification)
        })
        
        return mainContext
    }()
    
}