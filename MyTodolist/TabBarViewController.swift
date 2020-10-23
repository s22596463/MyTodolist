//
//  TabBarViewController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/23.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        setupUI()
    }
    
    func setupUI(){
        tabBar.standardAppearance.backgroundColor = .gray
        tabBar.standardAppearance.selectionIndicatorTintColor = .customBlue
        
        tabBar.items?[0].title = "Weather"
        tabBar.items?[1].title = "MyTodolist"
    }
    
}

extension TabBarViewController: UITabBarControllerDelegate{
    
}
