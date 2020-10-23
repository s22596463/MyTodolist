//
//  DonelistViewController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/22.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class DoneListViewController:  UIViewController,UITableViewDataSource,UITableViewDelegate,ListViewHostProtocol{
    
    
    var controller  = DoneListController()
    
    @IBOutlet weak var tableView: UITableView!
    
    func insert(at indices: [Int]) {
        //print("INSERT!")
        let indexPaths = indices.map { IndexPath(row: $0, section: 0) }
        print("insert indexPaths\(indexPaths)")
        tableView.insertRows(at: indexPaths, with: .automatic)
        //tableView.reloadData()
    }
    
    //    func delete(at indices: [Int]) {
    //        let indexPaths = indices.map { IndexPath(row: $0, section: 0)}
    //        print("insert indexPaths\(indexPaths)")
    //        tableView.deleteRows(at: indexPaths, with: .automatic)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(self.tableView)
        setupUI()
        controller.start()
        controller.listViewHost = self
        tableView.delegate = self
        tableView.dataSource = self
        //controller.listViewHost = self
        //controller.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
    }
    
    
    func setupUI(){
        self.title = "Donelist"
        self.navigationController?.navigationBar.barTintColor = .customBlue
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("tableView count:\(controller.container.count)")
        return self.controller.container.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = self.controller.container[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoneListCell", for: indexPath) as? DoneListTableViewCell else{
            assert(false, "Unhandled tableview cell")
            return UITableViewCell()
        }
        cell.setup(cellModel: cellModel)
        //print("DoneListCell.setup")
        //print("cellForRowAt indexPath.row = \(indexPath.row)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //print("willScrollTo")
        controller.willScrollTo(index: indexPath.row)
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHandler) in
//            let listToRemove = self.controller.container[indexPath.row]
//            DBManager.shared.deleteList(listToRemove: listToRemove)
//            self.controller.delete(at: indexPath.row)
//            completionHandler(true)
//        }
//        let configuration = UISwipeActionsConfiguration(actions: [ deleteAction])
//        configuration.performsFirstActionWithFullSwipe = false
//        return configuration
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}



