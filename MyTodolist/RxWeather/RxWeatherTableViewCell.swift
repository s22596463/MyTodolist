//
//  RxWeatherTableViewCell.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/11/6.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RxWeatherTableViewCell: UITableViewCell{
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "時間！"
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "溫度！"
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var humidLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "濕度！"
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        self.backgroundColor = .white
        self.selectionStyle = .gray
        self.addSubview(timeLabel)
        self.addSubview(tempLabel)
        self.addSubview(humidLabel)
        
        timeLabel.snp.makeConstraints{ (item) in
            item.top.equalToSuperview().offset(10)
            item.left.equalToSuperview().offset(16)
            item.right.equalToSuperview().offset(-16)
        }
        
        tempLabel.snp.makeConstraints{ (item) in
            item.top.equalToSuperview().offset(30)
            item.left.equalToSuperview().offset(16)
            item.right.equalToSuperview().offset(-16)
        }
        
        humidLabel.snp.makeConstraints{ (item) in
            item.top.equalToSuperview().offset(50)
            item.left.equalToSuperview().offset(16)
            item.right.equalToSuperview().offset(-16)
            item.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setup(data: daily){
        timeLabel.text = "時間：\(timeintervalToString(interval: data.dt))"
        timeLabel.isHidden = false
        tempLabel.text = "氣溫：\(data.temp.day)"
        tempLabel.isHidden = false
        humidLabel.text = "濕度：\(data.humidity)"
        humidLabel.isHidden = false
    }
    
    func timeintervalToString(interval: TimeInterval) -> String{
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM / dd EEE"
        let string = dateFormatter.string(from: date)
        return string
    }
    
    
}
