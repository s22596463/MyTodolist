//
//  TodolistViewController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/15.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class TodolistViewController:  UIViewController,UITableViewDataSource,UITableViewDelegate,ListViewHostProtocol{
    
    var controller  = TodolistController()
    
    @IBOutlet weak var tableView: UITableView!
    //        lazy var tableView: UITableView = {
    //        let tableView = UITableView(frame: self.view.bounds)
    //        tableView.delegate = self
    //        tableView.dataSource = self
    //        tableView.register(TodolistTableViewCell.self, forCellReuseIdentifier: "MyCell")
    //        return tableView
    //    }()
    
    func insert(at indices: [Int]) {
        //print("INSERT!")
        let indexPaths = indices.map { IndexPath(row: $0, section: 0) }
        print("insert indexPaths\(indexPaths)")
        //let contentOffset = tableView.contentOffset
        //DispatchQueue.main.async {
        //self.tableView.beginUpdates()
        //self.tableView.insertRows(at: indexPaths, with: .automatic)
        //self.tableView.endUpdates()
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.reloadData()
        //}
    }
    
    func add(at indices: [Int]){
        let indexPaths = indices.map { IndexPath(row: $0, section: 0) }
        print("add indexPaths\(indexPaths)")
        DispatchQueue.main.async {
            self.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func delete(at indices: [Int]) {
        let indexPaths = indices.map { IndexPath(row: $0, section: 0)}
        print("insert indexPaths\(indexPaths)")
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(self.tableView)
        SetUpUI()
        tableView.delegate = self
        tableView.dataSource = self
        controller.listViewHost = self
        controller.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        //tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navVC = segue.destination as? UINavigationController
        let addVC = navVC?.topViewController as? addViewController
        addVC?.preVC = self
    }
    
    
    func SetUpUI(){
        self.title = "My Todolist"
        self.navigationController?.navigationBar.barTintColor = UIColor.getCustomBlueColor()
        let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(TodolistViewController.addList))
        self.navigationItem.rightBarButtonItem = addBtn
        
    }
    
    @objc func addList(){
        performSegue(withIdentifier: "addViewController", sender: self)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView count:\(controller.container.count)")
        return self.controller.container.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = self.controller.container[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? TodolistTableViewCell else{
            assert(false, "Unhandled tableview cell")
            return UITableViewCell()
        }
        cell.setup(cellViewModel: cellViewModel)
        print("cell.setup")
        print("\(cellViewModel)")
        //print("cellForRowAt indexPath.row = \(indexPath.row)")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //print("willScrollTo")
        controller.willScrollTo(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHandler) in
            let listToRemove = self.controller.container[indexPath.row]
            DBManager.shared.deleteList(listToRemove: listToRemove)
            self.controller.delete(at: indexPath.row)
            completionHandler(true)
        }
        let doneAction = UIContextualAction(style: .normal, title: "Done"){ (action, view, completionHandler) in
            completionHandler(true)
        }
        doneAction.backgroundColor = UIColor.getCustomBlueColor()
        let configuration = UISwipeActionsConfiguration(actions: [ doneAction, deleteAction])
        //configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}


