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


class TodolistViewController:  UIViewController{
    
    lazy var viewModel = TodolistViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.initData()
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        //tableView.dropDelegate = self
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
            if tableView.indexPathForSelectedRow?.section == 0{
                addVC?.listToUpdate = viewModel.pinnedListCellModels[tableView.indexPathForSelectedRow!.row]
            }else{
                 addVC?.listToUpdate = viewModel.unpinnedListCellModels[tableView.indexPathForSelectedRow!.row]
            }
        case "AddListViewController":
            addVC?.tag = "add"
        default:
            print("")
        }
    }
    
    func setupUI(){
        //self.title = "My Todolist"
        self.navigationItem.title = "My Todolist"
        self.navigationController?.navigationBar.barTintColor = .customBlue
        let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(TodolistViewController.addListBtn))
        self.navigationItem.rightBarButtonItem = addBtn
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TodolistViewController.doneListBtn))
        self.navigationItem.leftBarButtonItem = doneBtn
    }
    
    @objc func addListBtn(){
        performSegue(withIdentifier: "AddListViewController", sender: self)
    }
    
    @objc func doneListBtn(){
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
    
}

extension TodolistViewController: UITableViewDataSource,UITableViewDelegate{
    
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
        //print("numberOfRows\(numberOfRows)")
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
        print(cellModel!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section){
        case 0:
            return "Pinned List"
        case 1:
            return "Unpinned List"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditListViewController", sender: self)
    }
    
    
    func dragItems(for indexPath: IndexPath) -> [UIDragItem]{
        var model: TodolistCellModel?
        if indexPath.section == 0{
            model = viewModel.pinnedListCellModels[indexPath.row]
        }else if indexPath.row == 1{
            model = viewModel.unpinnedListCellModels[indexPath.row]
        }
        let itemProvider = NSItemProvider(object: (model?.titleText ?? "default") as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
//    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
//        return canHandle(session)
//    }

    
    
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
        doneAction.backgroundColor = .customBlue
        let configuration = UISwipeActionsConfiguration(actions: [ doneAction, deleteAction])
        //configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.moveItem(at: sourceIndexPath, to: destinationIndexPath)
        tableView.reloadData()
    }
    
}

extension TodolistViewController: UITableViewDragDelegate{

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return dragItems(for: indexPath)
    }

}

//extension TodolistViewController: UITableViewDropDelegate {
//
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//    }
//
//    func canHandle(_ session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: NSString.self)
//    }

//    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
//        // The .move operation is available only for dragging within a single app.
//        print("dropSessionDidUpdate")
//        if tableView.hasActiveDrag {
//            if session.items.count > 1 {
//                return UITableViewDropProposal(operation: .cancel)
//            } else {
//                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//            }
//        } else {
//            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
//        }
//    }

//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//        print("performDropWith")
//        let destinationIndexPath: IndexPath
//
//        if let indexPath = coordinator.destinationIndexPath {
//            destinationIndexPath = indexPath
//        } else {
//            // Get last index path of table view.
//            let section = tableView.numberOfSections - 1
//            let row = tableView.numberOfRows(inSection: section)
//            destinationIndexPath = IndexPath(row: row, section: section)
//        }
//
//        coordinator.session.loadObjects(ofClass: NSString.self) { items in
//            // Consume drag items.
//            let stringItems = items as! [String]
//
//            var indexPaths = [IndexPath]()
//            for (index, item) in stringItems.enumerated() {
//                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
//                //self.model.addItem(item, at: indexPath.row)
//                indexPaths.append(indexPath)
//            }
//            tableView.insertRows(at: indexPaths, with: .automatic)
//        }
//    }
//}


