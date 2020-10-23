//
//  WeatherViewController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/23.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        self.title = "Weather"
        self.navigationController?.navigationBar.barTintColor = .customBlue
    }
    
}