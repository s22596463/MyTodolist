//
//  TodolistTableViewCell.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/15.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit

class TodolistTableViewCell: UITableViewCell{
    
    @IBOutlet var label: UILabel!
    
    func setup(cellViewModel: TodolistCellViewModel){
        label.text = cellViewModel.titleText
        label.isHidden = false
    }
    
}

