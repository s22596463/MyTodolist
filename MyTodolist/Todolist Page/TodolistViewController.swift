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


class TodolistViewController:  UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    lazy var viewModel = TodolistViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.initData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navVC = segue.destination as? UINavigationController
        let addVC = navVC?.topViewController as? AddListViewController
        addVC?.preVC = self
        switch segue.identifier{
        case "EditListViewController":
            addVC?.tag = "edit"
        case "AddListViewController":
            addVC?.tag = "add"
        default:
            print("")
        }
        
    }
    
    
    func setupUI(){
        self.title = "My Todolist"
        self.navigationController?.navigationBar.barTintColor = UIColor.getCustomBlueColor()
        let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(TodolistViewController.addList))
        self.navigationItem.rightBarButtonItem = addBtn
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TodolistViewController.doneList))
        self.navigationItem.leftBarButtonItem = doneBtn
    }
    
    @objc func addList(){
        performSegue(withIdentifier: "AddListViewController", sender: self)
    }
    
    @objc func doneList(){
        performSegue(withIdentifier: "DoneListViewController", sender: self)
    }
    
    func insertNewList(isPinned: Bool){
        var indexPath = [IndexPath]()
        if isPinned{
            indexPath.append(IndexPath(row: tableView(self.tableView, numberOfRowsInSection: 0), section: 0))
        }else{
            indexPath.append(IndexPath(row: tableView(self.tableView, numberOfRowsInSection: 1), section: 1))
        }
        DispatchQueue.main.async {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPath, with: .automatic)
        self.tableView.endUpdates()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 10
        if section == 0{
            numberOfRows = viewModel.pinnedListCellModels.count
        }else if section == 1{
            numberOfRows = viewModel.unpinnedListCellModels.count
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellModel: TodolistCellModel?
        if indexPath.section == 0{
            cellModel = viewModel.pinnedListCellModels[indexPath.row]
        }else if indexPath.section == 1{
            cellModel = viewModel.unpinnedListCellModels[indexPath.row]
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodolistCell", for: indexPath) as? TodolistTableViewCell else{
            assert(false, "Unhandled tableview cell")
            return UITableViewCell()
        }
        cell.setup(cellModel: cellModel!)
        print("todolistCell.setup")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditListViewController", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHandler) in
            var listToRemove: TodolistCellModel?
            if indexPath.section == 0{
                listToRemove = self.viewModel.pinnedListCellModels[indexPath.row]
            }else if indexPath.section == 1{
                listToRemove = self.viewModel.unpinnedListCellModels[indexPath.row]
            }
            self.viewModel.deleteList(listToRemove: listToRemove!,indexRow: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let doneAction = UIContextualAction(style: .normal, title: "Done"){ (action, view, completionHandler) in
            var listToDone: TodolistCellModel?
            if indexPath.section == 0{
                listToDone = self.viewModel.pinnedListCellModels[indexPath.row]
            }else if indexPath.section == 1{
                listToDone = self.viewModel.unpinnedListCellModels[indexPath.row]
            }
            self.viewModel.doneList(listToDone: listToDone!,indexRow: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
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


