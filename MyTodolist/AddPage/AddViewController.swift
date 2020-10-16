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
        DBManager.shared.addList(attributeInfo: [
            "title": "wow",
            "isPinned": true
        ])
        
        self.navigationController?.dismiss(animated: false, completion:{
            //self.preVC?.reloadData()
            self.preVC?.controller.totalCount += 1
            self.preVC?.controller.willScrollTo(index: (self.preVC?.controller.container.count)!-1)
            //print(self.preVC?.controller.container.count)
        })

    }
    
}
