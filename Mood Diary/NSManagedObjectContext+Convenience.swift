//
//  NSManagedObjectContext+Convenience.swift
//  Mood Diary
//
//  Created by Vikas Shah on 5/16/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import CoreData

typealias VSChangeBlock = (NSManagedObjectContext) -> Void
typealias VSSaveCompletionHandler = (Bool, NSError?) -> Void

extension NSManagedObjectContext {
    fileprivate func vs_rootSavingContext() -> NSManagedObjectContext {
        return VSCoreDataManager.sharedManager.rootSavingContext
    }
    
    func vs_defaultContext() -> NSManagedObjectContext {
        return VSCoreDataManager.sharedManager.mainContext
    }
    
    fileprivate func newPrivateQueuContextWithParent(_ parentContext: NSManagedObjectContext) -> NSManagedObjectContext {
        let newContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        newContext.parent = parentContext
        
        return newContext
    }
    
    //MARK: - Saving
    
    func saveToPersistentStore(_ synchronously: Bool, completion: VSSaveCompletionHandler?) {
        var saveResult = false
        var saveError: NSError? = nil
        
        if hasChanges {
            //make save block
            let saveBlock = {
                do {
                    try self.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    saveError = error as NSError
                    NSLog("Unresolved error \(saveError), \(saveError?.userInfo)")
                    abort()
                }
                defer {
                    if self.parent != nil {
                        self.parent?.saveToPersistentStore(synchronously, completion: completion)
                    } else {
                        DispatchQueue.main.async(execute: {
                            completion?(saveResult, saveError)
                        })
                    }
                }
            }
            
            //execute save block accordingly
            if synchronously {
                performAndWait(saveBlock)
            } else {
                perform(saveBlock)
            }
        }
    }
    
    func saveChanges(_ changes: @escaping VSChangeBlock, completion: VSSaveCompletionHandler? = nil) {
        let context = newPrivateQueuContextWithParent(vs_rootSavingContext())
        context.perform {
            changes(context)
            
            context.saveToPersistentStore(false, completion: completion)
        }
    }
    
    func saveChangesAndWait(_ changes: @escaping VSChangeBlock) {
        let context = newPrivateQueuContextWithParent(vs_rootSavingContext())
        context.performAndWait({
            changes(context)
            
            context.saveToPersistentStore(true, completion: nil)
        })
    }
}
