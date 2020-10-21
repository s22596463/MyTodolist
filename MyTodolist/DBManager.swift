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
        //UserDefaults.standard.set(1, forKey: "idSeq_list")
    }
    
    
    func fetchAllList() -> [Todolist]{
        var lists: [Todolist]?
        try! myContext.fetch(Todolist.fetchRequest())
        do {
            lists = try myContext.fetch(Todolist.fetchRequest())
        }
        catch{
        }
        let lists_all = lists ?? [Todolist]()
        return lists_all
    }
    
    func fetchList(offset: Int, perpage: Int) -> (list: [Todolist], totalResults: Int){
        var lists = [Todolist]()
        //try! myContext.fetch(Todolist.fetchRequest())
        do {
            let request = Todolist.fetchRequest() as NSFetchRequest<Todolist>
            request.fetchLimit = perpage
            request.fetchOffset = offset
            //let pred = NSPredicate(format:"")
            lists = try myContext.fetch(request)
        }
        catch{
        }
        let totalRequest = try! myContext.fetch(Todolist.fetchRequest())
        let totalResults = totalRequest.count
        
        return (lists, totalResults)
    }
    
    func fetchRestList(offset: Int) -> [Todolist]{
        var list: [Todolist]?
        
        do {
            let request = Todolist.fetchRequest() as NSFetchRequest<Todolist>
            //request.fetchLimit =
            request.fetchOffset = offset
            list = try myContext.fetch(request)
        }
        catch{
        }
        print("fetchRestList\(list)")
        return list!
    }
    
    func addList(attributeInfo: [String:Any]){
        //let idSeq = UserDefaults.standard.integer(forKey: "idSeq_list")
        let list = Todolist(context: myContext)
        //list.id = Int32(idSeq+1)
        list.title = attributeInfo["title"] as? String
        list.isPinned = attributeInfo["isPinned"] as! Bool
        do{
            try myContext.save()
            //id auto increment
            //UserDefaults.standard.set(list.id, forKey: "idSeq_list")
        }
        catch{
        }
        
    }
    
    func deleteList(listToRemove: TodolistCellViewModel){
        let request = NSFetchRequest<NSFetchRequestResult>(
            entityName: "Todolist")
        request.predicate = nil
        request.predicate = NSPredicate(format: "title = \(listToRemove.titleText) AND isPinned = \(listToRemove.isPinned)")
        do{
            let listsToRemove = try myContext.fetch(request) as! [NSManagedObject]
            for listToRemove in listsToRemove{
                myContext.delete(listToRemove)
            }
            try myContext.save()
        }
        catch{
        }
    }
    
    //    func getTodolist(index: Int,perPage: Int) -> [TodolistModel]{
    //        print("DBManager from index: \(index)")
    //        let countArray = [Int](index...index+perPage-1)
    //        var todolistModels = [TodolistModel]()
    //        countArray.forEach{ (count) in
    //            let model = TodolistModel(title:count)
    //            todolistModels.append(model)
    //        }
    //        return todolistModels
    //    }
    
}
