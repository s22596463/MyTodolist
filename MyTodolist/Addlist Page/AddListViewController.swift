//
//  AddViewController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/15.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit


class AddListViewController :UIViewController {
    
    weak var preVC: TodolistViewController?
    var tag = "add"
    var listToUpdate: TodolistCellModel?

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var pinSwitch: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if tag == "edit" { loadData() }
    }
   
    
    func setupUI(){
        if tag == "add"{
            self.title = "Add new Tololist"
            self.navigationController?.navigationBar.barTintColor = .customBlue
            let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddListViewController.addList))
            self.navigationItem.rightBarButtonItem = addBtn
        }
        if tag == "edit"{
            self.title = ""
            self.navigationController?.navigationBar.barTintColor = .customBlue
            let editBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(AddListViewController.updateList))
            self.navigationItem.rightBarButtonItem = editBtn
        }
    }
    
    func loadData(){
        titleTextField.text = listToUpdate!.titleText
        pinSwitch.isOn = listToUpdate!.isPinned
    }
    
    @objc func addList(){
        self.view.endEditing(true)
        
        let id = UserDefaults.standard.integer(forKey: "id")
        DBManager.shared.addList(attributeInfo: [
            "title": titleTextField.text ?? "default",
            "isPinned": pinSwitch.isOn,
            "isDone": false,
            "id":Int32(id)
        ])
        
        let listToInsert = TodolistCellModel(titleText: titleTextField.text ?? "default", isPinned: pinSwitch.isOn, id: id)
        self.navigationController?.dismiss(animated: true, completion:{
            print("dimiss")
            self.preVC?.insertNewList(isPinned: listToInsert.isPinned)
            self.preVC?.viewModel.insertList(listToInsert: listToInsert)
//            let scrollToRow = IndexPath(row: (self.preVC?.tableView.numberOfRows(inSection: <#T##Int#>) , section: 0)
//            self.preVC?.tableView.scrollToRow(at: scrollToRow, at: .bottom, animated: true)
        })

    }
    
    @objc func updateList(){
        self.view.endEditing(true)
        
        DBManager.shared.updateList(listToUpdate: listToUpdate!, attributeInfo: [
            "title": titleTextField.text ?? "default",
            "isPinned": pinSwitch.isOn,
            "isDone": false,
        ])
        
        let listAfterUpdate = TodolistCellModel(titleText: titleTextField.text ?? "default", isPinned: pinSwitch.isOn, id: listToUpdate!.id)
        self.navigationController?.dismiss(animated: true, completion:{
            print("dimiss")
            self.preVC?.viewModel.updateList(listToUpadte: self.listToUpdate!, listAfterUpdate: listAfterUpdate)
            self.preVC?.tableView.reloadData()
            //TODO:用insert和delete實現更改動畫
        })
    }
    
}

extension AddListViewController: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
