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
    
    func updateList(listToUpadte: TodolistCellModel, listAfterUpdate: TodolistCellModel){
        if listToUpadte.isPinned{
            pinnedListCellModels = pinnedListCellModels.filter{ $0.id != listToUpadte.id }
        }else{
            unpinnedListCellModels = unpinnedListCellModels.filter{ $0.id != listToUpadte.id }
        }        
        insertList(listToInsert: listAfterUpdate)
    }
    
    func pinnedList(listToPinned: TodolistCellModel, indexRow: Int){
        DBManager.shared.pinnedList(listToPinned: listToPinned)
        pinnedListCellModels.insert(listToPinned, at: indexRow)
    }
    
    func unpinnedList(listToUnpinned: TodolistCellModel, indexRow: Int){
        DBManager.shared.unpinnedList(listToUnpinned: listToUnpinned)
        unpinnedListCellModels.insert(listToUnpinned, at: indexRow)
    }
    
    func moveItem(at sourceIndex: IndexPath, to destinationIndex: IndexPath) {
        //print("pinnedListCellModels:\(pinnedListCellModels)")
        //print("unpinnedListCellModels:\(unpinnedListCellModels)")
        guard sourceIndex != destinationIndex else { return }
        var model: TodolistCellModel?
        if sourceIndex.section == 0{
            model = pinnedListCellModels[sourceIndex.row]
            pinnedListCellModels.remove(at: sourceIndex.row)
        }else if sourceIndex.section == 1{
            model = unpinnedListCellModels[sourceIndex.row]
            unpinnedListCellModels.remove(at: sourceIndex.row)
        }
        if destinationIndex.section == 0{
            model?.isPinned = true
            pinnedList(listToPinned: model!, indexRow: destinationIndex.row)
        }else if destinationIndex.section == 1 {
            model?.isPinned = false
            unpinnedList(listToUnpinned: model!, indexRow: destinationIndex.row)
        }
        //print("moveItem")
        //print("pinnedListCellModels:\(pinnedListCellModels)")
        //print("unpinnedListCellModels:\(unpinnedListCellModels)")
    }
    
    private func buildCellModel(todolist: Todolist) -> TodolistCellModel {
        return TodolistCellModel(titleText: todolist.title!, isPinned: todolist.isPinned,id: Int(todolist.id))
    }
}
