//
//  DonelistTableViewCell.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/22.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit

class DoneListTableViewCell: UITableViewCell{
    
    @IBOutlet var label: UILabel!
        
    func setup(cellModel: DoneListCellModel){
        self.selectionStyle = .none
        label.text = cellModel.titleText
        label.isHidden = false
    }
    
}
