//
//  CoreDataManager.swift
//  GitTest
//
//  Created by Marcos Barbosa on 28/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func registerHistory(repository: Repository, completionHandler: @escaping(Bool) -> Void){
        
        let context = appDelegate.persistentContainer.viewContext
        
        let history = NSEntityDescription.insertNewObject(forEntityName: "Repositories", into: context)
        
        history.setValue(repository.authorName, forKey: "authorName")
        history.setValue(repository.authorPhoto, forKey: "authorPhoto")
        history.setValue(repository.forks, forKey: "forks")
        history.setValue(repository.repositoryDescription, forKey: "repositoryDescription")
        history.setValue(repository.repositoryName, forKey: "repositoryName")
        history.setValue(repository.stars, forKey: "stars")
        history.setValue(Date(), forKey: "visited")
        
        let requisition = NSFetchRequest<NSFetchRequestResult>(entityName: "Repositories")
        
        requisition.predicate = NSPredicate(format: "repositoryDescription = %@", "\(repository.repositoryName)")
        
        do{
            let fetchedResults = try context.fetch(requisition)
            
            for entity in fetchedResults{
                context.delete(entity as! NSManagedObject)
            }
            
        }catch{
            print("erro")
        }
        
        do {
            try context.save()
            print("data 1")
            completionHandler(true)
        } catch {
            print("data 2")
            completionHandler(false)
        }
        
    }
    
}
