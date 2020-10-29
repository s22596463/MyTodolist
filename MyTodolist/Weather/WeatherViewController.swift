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
    
    var cellModel = CurrentWeatherCellModel()
    
    let cellSpacingHeight: CGFloat = 10
    let cellReuseIdentifier = "CurrenWeatherCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        cellModel.getCurrentWeather {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setupUI(){
        self.title = "Current Weather"
        self.navigationController?.navigationBar.barTintColor = .customBlue
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellModel.weatherList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? CurrentWeatherTableViewCell else{
                   assert(false, "Unhandled tableview cell")
                   return UITableViewCell()
               }
        cell.setup(cellModel: cellModel, indexPath: indexPath)
        return cell
    }
    

}
