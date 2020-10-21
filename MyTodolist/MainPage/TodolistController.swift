//
//  TodolistController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/15.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import CoreData

class TodolistController: PaginationController{

    var listViewHost: ListViewHostProtocol?
    //weak var listViewHost: ListViewHostProtocol?
    
    typealias T = TodolistCellViewModel
    
    var perPage: Int { return 10 }
    var totalCount: Int = 0
    var container: [TodolistCellViewModel] = []
    
    func start(){
        initFetchData()
        print("START!")
    }
    
//    func insert(at: [Int]) {
//       }

//    func fetchData(at offset: Int, completion complete: @escaping([TodolistCellViewModel])-> Void){
//        print("fetchData")
//        let todolists = DBManager.shared.fetchAllList()
//        self.totalCount = todolists.count
//        let cellViewModels = self.buildCellViewModels(todolists: todolists)
//       complete(cellViewModels)
//    }
    
    func fetchData(at offset: Int, completion complete: @escaping([TodolistCellViewModel])-> Void){
        print("fetchData")
        //let currentPage = Int(offset/perPage)
        let todolists = DBManager.shared.fetchList(offset: offset, perpage: perPage)
        self.totalCount = todolists.totalResults
        //self.totalCount = todolists.count
        let cellViewModels = self.buildCellViewModels(todolists: todolists.list)
        complete(cellViewModels)
    }
    
    func fetchRestData(completion complete: @escaping([TodolistCellViewModel])-> Void){
        let todolists = DBManager.shared.fetchRestList(offset: self.container.count)
        self.totalCount += 1
        let cellViewModels = self.buildCellViewModels(todolists: todolists)
        complete(cellViewModels)
    }

//    private func buildCellViewModels(todolists: [TodolistModel]) -> [TodolistCellViewModel]{
//        let fromCount = container.count
//        return todolists.enumerated().map{
//            buildCellViewModel(index: $0.offset+fromCount, todolist: $0.element)
//        }
//    }
    
    private func buildCellViewModels(todolists: [Todolist]) -> [TodolistCellViewModel]{
        let fromCount = container.count
        return todolists.enumerated().map{
            buildCellViewModel(index: $0.offset+fromCount, todolist: $0.element)
        }
    }
    
//    private func buildCellViewModel(index: Int, todolist: TodolistModel) -> TodolistCellViewModel {
//        return TodolistCellViewModel(titleText: "\(todolist.title)")
//    }
    
    private func buildCellViewModel(index: Int, todolist: Todolist) -> TodolistCellViewModel {
        return TodolistCellViewModel(titleText: todolist.title!, isPinned: todolist.isPinned)
    }
    
    
    
}

//extension TodolistController: NSFetchResultsControllerDelegate{
//    var fetchResultController : NSFetchResultsController<Todolist>
//}

