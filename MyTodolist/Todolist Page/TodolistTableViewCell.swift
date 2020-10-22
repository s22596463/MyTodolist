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
    @IBOutlet var img_isPinned: UIImageView!
        
    func setup(cellModel: TodolistCellModel){
        self.selectionStyle = .none
        label.text = cellModel.titleText
        label.isHidden = false
        if cellModel.isPinned{
            img_isPinned.isHidden = false
        }else{
            img_isPinned.isHidden = true
        }
    }
    
}

