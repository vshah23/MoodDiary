//
//  NSManagedObjectContext+Convenience.swift
//  Mood Diary
//
//  Created by Vikas Shah on 5/16/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import CoreData

typealias VSChangeBlock = NSManagedObjectContext -> Void
typealias VSSaveCompletionHandler = (Bool, NSError?) -> Void

extension NSManagedObjectContext {
    private func vs_rootSavingContext() -> NSManagedObjectContext {
        return VSCoreDataManager.sharedManager.rootSavingContext
    }
    
    func vs_defaultContext() -> NSManagedObjectContext {
        return VSCoreDataManager.sharedManager.mainContext
    }
    
    private func newPrivateQueuContextWithParent(parentContext: NSManagedObjectContext) -> NSManagedObjectContext {
        let newContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        newContext.parentContext = parentContext
        
        return newContext
    }
    
    //MARK: - Saving
    
    func saveToPersistentStore(synchronously: Bool, completion: VSSaveCompletionHandler?) {
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
                    if self.parentContext != nil {
                        self.parentContext?.saveToPersistentStore(synchronously, completion: completion)
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            completion?(saveResult, saveError)
                        })
                    }
                }
            }
            
            //execute save block accordingly
            if synchronously {
                performBlockAndWait(saveBlock)
            } else {
                performBlock(saveBlock)
            }
        }
    }
    
    func saveChanges(changes: VSChangeBlock, completion: VSSaveCompletionHandler? = nil) {
        let context = newPrivateQueuContextWithParent(vs_rootSavingContext())
        context.performBlock {
            changes(context)
            
            context.saveToPersistentStore(false, completion: completion)
        }
    }
    
    func saveChangesAndWait(changes: VSChangeBlock) {
        let context = newPrivateQueuContextWithParent(vs_rootSavingContext())
        context.performBlockAndWait({
            changes(context)
            
            context.saveToPersistentStore(true, completion: nil)
        })
    }
}