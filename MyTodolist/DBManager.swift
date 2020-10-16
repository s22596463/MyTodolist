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
    
    func fetchList(currentPage: Int) -> [Todolist]{
        var lists: [Todolist]?
        //try! myContext.fetch(Todolist.fetchRequest())
        do {
            lists = try myContext.fetch(Todolist.fetchRequest())
            //fetch certain lists
        }
        catch{

        }
        let lists_all = lists ?? [Todolist]()
        return lists_all
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
