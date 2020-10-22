//
//  TodolistViewModel.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/22.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation

class TodolistViewModel {
    
    var pinnedListCellModels = [TodolistCellModel]()
    var unpinnedListCellModels = [TodolistCellModel]()
    
    
    func initData(){
        // DB FetchData完放進CellModels裡面
        let pinnedList = DBManager.shared.fetchPinnedList()
        let unpinnedList = DBManager.shared.fetchUnpinnedList()
        
        pinnedListCellModels.append(contentsOf: pinnedList.enumerated().map{
            buildCellModel(todolist: $0.element)
        })
        unpinnedListCellModels.append(contentsOf: unpinnedList.enumerated().map{
            buildCellModel(todolist: $0.element)
        })
    }
    
    func deleteList(listToRemove: TodolistCellModel, indexRow: Int){
        
        DBManager.shared.deleteList(listToRemove: listToRemove)
         //把pinnedListCellModels或unpinnedListCellModels裡的刪掉
        if listToRemove.isPinned{
            pinnedListCellModels.remove(at: indexRow)
        }else{
            unpinnedListCellModels.remove(at: indexRow)
        }
    }
    
    func insertList(listToInsert: TodolistCellModel){
        //新增進pinnedListCellModels或unpinnedListCellModels裡
        if listToInsert.isPinned{
            pinnedListCellModels.append(listToInsert)
        }else{
            unpinnedListCellModels.append(listToInsert)
        }
    }
    
    func doneList(listToDone: TodolistCellModel, indexRow: Int){
        DBManager.shared.doneList(listToDone: listToDone)
        //把pinnedListCellModels或unpinnedListCellModels裡的刪掉
        if listToDone.isPinned{
            pinnedListCellModels.remove(at: indexRow)
        }else{
            unpinnedListCellModels.remove(at: indexRow)
        }
    }
    
    func updateList(){
    }
    
    private func buildCellModel(todolist: Todolist) -> TodolistCellModel {
        return TodolistCellModel(titleText: todolist.title!, isPinned: todolist.isPinned,id: Int(todolist.id))
    }
}
