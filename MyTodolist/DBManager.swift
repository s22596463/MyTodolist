//
//  DBManager.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/15.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBManager{
    
    static let shared = DBManager(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext )
    
    var myContext: NSManagedObjectContext! = nil
    
    private init(context: NSManagedObjectContext){
        self.myContext = context
    }
    
    
    //    func fetchAllList() -> [Todolist]{
    //        var lists: [Todolist]?
    //        try! myContext.fetch(Todolist.fetchRequest())
    //        do {
    //            lists = try myContext.fetch(Todolist.fetchRequest())
    //        }
    //        catch{
    //        }
    //        let lists_all = lists ?? [Todolist]()
    //        return lists_all
    //    }
    
    //fetch pinned and undone list
    func fetchPinnedList() -> [Todolist]{
        var lists = [Todolist]()
        //try! myContext.fetch(Todolist.fetchRequest())
        do {
            let request = Todolist.fetchRequest() as NSFetchRequest<Todolist>
            let pred = NSPredicate(format:"isPinned = %d AND isDone = %d",true,false)
            request.predicate = pred
            lists = try myContext.fetch(request)
        }
        catch{
        }
        
        return lists
    }
    
    //fetch unpinned and undone list
    func fetchUnpinnedList() -> [Todolist]{
        var lists = [Todolist]()
        do {
            let request = Todolist.fetchRequest() as NSFetchRequest<Todolist>
            let pred = NSPredicate(format:"isPinned = %d AND isDone = %d",false,false)
            request.predicate = pred
            lists = try myContext.fetch(request)
        }
        catch{
        }
        return lists
    }
    
    //fetch done list
    func fetchDoneList(offset: Int, perpage: Int) -> (list: [Todolist], totalResults: Int){
        var lists = [Todolist]()
        //try! myContext.fetch(Todolist.fetchRequest())
        do {
            let request = Todolist.fetchRequest() as NSFetchRequest<Todolist>
            let pred = NSPredicate(format:"isDone = %d",true)
            request.predicate = pred
            request.fetchLimit = perpage
            request.fetchOffset = offset
            lists = try myContext.fetch(request)
        }
        catch{
        }
        let totalRequest = try! myContext.fetch(Todolist.fetchRequest())
        let totalResults = totalRequest.count
        
        return (lists, totalResults)
    }
    
    func addList(attributeInfo: [String:Any]){
        
        let list = Todolist(context: myContext)
        list.title = attributeInfo["title"] as? String
        list.isPinned = attributeInfo["isPinned"] as! Bool
        list.isDone = attributeInfo["isDone"] as! Bool
        list.id = attributeInfo["id"] as! Int32
        do{
            try myContext.save()
        }
        catch{
        }
        let id = UserDefaults.standard.integer(forKey: "id")
        //id auto increment
        UserDefaults.standard.set(id+1, forKey: "id")
    }
    
    func deleteList(listToRemove: TodolistCellModel){
        
        let request = NSFetchRequest<NSFetchRequestResult>(
            entityName: "Todolist")
        request.predicate = nil
        request.predicate = NSPredicate(format: "id == \(listToRemove.id)")
        do{
            let listsToRemove = try myContext.fetch(request) as! [NSManagedObject]
            for list in listsToRemove{
                myContext.delete(list)
            }
            try myContext.save()
        }
        catch{
        }
    }
    
    func updateList(listToUpdate: TodolistCellModel, attributeInfo: [String:Any]){
        
        let request = Todolist.fetchRequest() as NSFetchRequest<Todolist>
        request.predicate = nil
        request.predicate = NSPredicate(format: "id == \(listToUpdate.id)")
        do{
            let listsToUpdate = try myContext.fetch(request)
            listsToUpdate[0].title = attributeInfo["title"] as? String
            listsToUpdate[0].isPinned = attributeInfo["isPinned"] as! Bool
            listsToUpdate[0].isDone = attributeInfo["isDone"] as! Bool
            try myContext.save()
        }
        catch{
            
        }
    }
    
    // mark undone list as done
    func doneList(listToDone: TodolistCellModel){
        let request = Todolist.fetchRequest() as NSFetchRequest<Todolist>
        request.predicate = nil
        request.predicate = NSPredicate(format: "id == \(listToDone.id)")
        do{
            let listsToDone = try myContext.fetch(request)
            listsToDone[0].isDone = true
            try myContext.save()
        }
        catch{
            
        }
    }
    
    func pinnedList(listToPinned: TodolistCellModel){
        let request = Todolist.fetchRequest() as NSFetchRequest<Todolist>
        request.predicate = nil
        request.predicate = NSPredicate(format: "id == \(listToPinned.id)")
        do{
            let listToPinned = try myContext.fetch(request)
            listToPinned[0].isPinned = true
            try myContext.save()
        }
        catch{
            
        }
    }
    
    func unpinnedList(listToUnpinned: TodolistCellModel){
        let request = Todolist.fetchRequest() as NSFetchRequest<Todolist>
        request.predicate = nil
        request.predicate = NSPredicate(format: "id == \(listToUnpinned.id)")
        do{
            let listToUnpinned = try myContext.fetch(request)
            listToUnpinned[0].isPinned = false
            try myContext.save()
        }
        catch{
            
        }
    }
    
}
