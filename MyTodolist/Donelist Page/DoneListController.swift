//
//  DoneListController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/22.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import CoreData

class DoneListController: PaginationController{

    weak var listViewHost: ListViewHostProtocol?
    
    typealias T = DoneListCellModel
    
    var perPage: Int { return 10 }
    var totalCount: Int = 0
    var container: [DoneListCellModel] = []
    
    func start(){
        initFetchData()
        print("START!")
    }
    
    func fetchData(at offset: Int, completion complete: @escaping([DoneListCellModel])-> Void){
        print("fetchData")
        let todolists = DBManager.shared.fetchDoneList(offset: offset, perpage: perPage)
        self.totalCount = todolists.totalResults
        let cellViewModels = self.buildCellModels(todolists: todolists.list)
        complete(cellViewModels)
    }
    
    private func buildCellModels(todolists: [Todolist]) -> [DoneListCellModel]{
        let fromCount = container.count
        return todolists.enumerated().map{
            buildCellModel(index: $0.offset+fromCount, todolist: $0.element)
        }
    }
    
    private func buildCellModel(index: Int, todolist: Todolist) -> DoneListCellModel {
        return DoneListCellModel(titleText: todolist.title!)
    }
    
    
    
}

