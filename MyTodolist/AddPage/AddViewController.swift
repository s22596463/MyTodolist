//
//  AddViewController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/15.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit


class addViewController :UIViewController {
    
    weak var preVC: TodolistViewController?

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var pinSwitch: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
    }
   
    
    func SetUpUI(){
        self.title = "Add new Tololist"
        self.navigationController?.navigationBar.barTintColor = UIColor.getCustomBlueColor()
        let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(TodolistViewController.addList))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    @objc func addList(){
        self.view.endEditing(true)
        
        DBManager.shared.addList(attributeInfo: [
            "title": titleTextField.text ?? "default",
            "isPinned": pinSwitch.isOn
        ])
        
        self.preVC?.controller.add()
        self.navigationController?.dismiss(animated: false, completion:{
            print("dimiss")
            let scrollToRow = IndexPath(row: (self.preVC?.controller.totalCount ?? 1)-1 , section: 0)
            self.preVC?.tableView.scrollToRow(at: scrollToRow, at: .bottom, animated: true)
        })

    }
    
}

extension addViewController: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
