//
//  Pagination.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/15.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation

protocol PaginationController: AnyObject{
    associatedtype T //data type of list item eg.cellViewModel
    typealias CompleteClosure = ([T]) -> Void
    var perPage: Int {get}
    var totalCount: Int {get}
    
    var container: [T] {get set}
    var listViewHost: ListViewHostProtocol? { get }
    //paginationController直接對listViewHostProtocol操作
    //可以是任何View，在要使用他的Controller指定即可
    
    func willScrollTo(index: Int) //extension中實作，所有controller共享的邏輯
    
    func fetchData(at offset: Int, completion: @escaping CompleteClosure)
    //func fetchData(at offset: Int) -> [T]
    //offset從哪裡開始抓資料 //留給不同Controller自己實作
    
    func insert(at: [Int])
    
    func initFetchData()
}

extension PaginationController{
    func initFetchData(){
        willScrollTo(index: 0)
    }
    
    func willScrollTo(index: Int){
        
        //print("index:\(index)")
        //print("container.count:\(container.count)")
        print("willScrollTo")
        print("index:\(index)")
        print("container.count:\(container.count)")
        print("totalCount:\(totalCount)")
        if index == container.count-1 && container.count < totalCount || container.count == 0{
            print("willScrollTo IN")
            fetchData(at: container.count){
                let from = self.container.count
                self.container.append(contentsOf: $0)
                let to = self.container.count
                print("container\(self.container)")
                let indicesToBeInserted = [Int](from..<to)
                self.listViewHost?.insert(at: indicesToBeInserted)
            }
        }

    }
}

