
//
//  RxWeatherViewController.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/11/6.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
//import RxCocoa
import SnapKit

class RxWeatherViewController: UIViewController, UITableViewDelegate{
    
    private let tableView: UITableView = {
        let tbView = UITableView()
        
        tbView.separatorStyle = .singleLine
        tbView.backgroundColor = .white
        tbView.estimatedRowHeight = 70
        tbView.rowHeight = UITableView.automaticDimension
        //        let tbView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height), style: .insetGrouped)
        
        tbView.register(RxWeatherTableViewCell.self, forCellReuseIdentifier: "RxWeatherTableViewCell")
        
        tbView.translatesAutoresizingMaskIntoConstraints = false
        return tbView
    }()
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .customBlue
        btn.setTitle("台北市", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let picker: UIPickerView = {
        let pi = UIPickerView()
        return pi
    }()
    
    let screenSize = UIScreen.main.bounds
    let viewModel = RxWeatherViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getWeather(lat: 25, lon: 130)
    }
    
    func setupBind(){
        
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.weather.bind(to: tableView.rx.items) { (tableView, row, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RxWeatherTableViewCell") as? RxWeatherTableViewCell else{ return UITableViewCell() }
            print(element)
            print(tableView.numberOfRows(inSection: 0))
            cell.setup(data: element)
            return cell
        }.disposed(by: disposeBag)
        
        viewModel.loading
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { (isLoading) in
                print("成功！")
                print("isloading:\(isLoading)")
            },onError: { error in
                print("失败 Error: \(error)")
            }, onCompleted: {
                print("完成!")
            }).disposed(by: disposeBag)
        
//        Observable.just(["台北市","新北市"]).bind(to: picker.rx.itemTitles(<#T##source: ObservableType##ObservableType#>))
        
    }
    
    func setupUI(){
        self.navigationItem.title = "Weekly Weather using RxSwift"
        self.navigationController?.navigationBar.barTintColor = .customBlue
        
        self.tableView.register(RxWeatherTableViewCell.self, forCellReuseIdentifier: "RxWeatherTableViewCell")
        
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    //    }
    
}
