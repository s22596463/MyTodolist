//
//  WeatherViewController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/23.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeatherCellModel = CurrentWeatherCellModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setupUI(){
        self.title = "Weather"
        self.navigationController?.navigationBar.barTintColor = .customBlue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrenWeatherCell", for: indexPath) as? CurrentWeatherTableViewCell else{
                   assert(false, "Unhandled tableview cell")
                   return UITableViewCell()
               }
        cell.setup(cellModel: currentWeatherCellModel)
        return cell
    }
    

}
