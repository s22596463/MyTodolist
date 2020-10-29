//
//  WeatherTableViewCell.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/28.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CurrentWeatherTableViewCell: UITableViewCell{
    
    weak var cellModel: CurrentWeatherCellModel!{
        didSet{
            temperatureLabel.text = "\(cellModel.temperature)°C"
            feelLikeLabel.text = "\(cellModel.feelLike)°C"
            humidityLabel.text = "\(cellModel.humidity)%"
            sunriseLabel.text = cellModel.sunrise
            sunsetLabel.text = cellModel.sunset
            self.loadWeatherIcon(url: cellModel.weatherIconURL)
            //weatherIcon.image = self.loadWeatherIcon(url: cellModel.weatherIconURL)
        }
    }
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    func setup(cellModel: CurrentWeatherCellModel){
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderColor = UIColor.customBlue.cgColor
        self.contentView.layer.borderWidth = 5
        self.selectionStyle = .none
        cellModel.getCurrentWeather(lat: 25.051880, lon: 121.557389){ model in
            self.cellModel = model
        }
        //print("setup")
    }
    
    
//    func loadWeatherIcon(url: String) -> UIImage{
//        let defaultImg = UIImage(systemName: "arrow.counterclockwise.circle")
//        defaultImg?.withTintColor(UIColor.darkGray)
//        guard let imgURL = URL(string: "http://openweathermap.org/img/wn/\(url)@2x.png") else { return defaultImg! }
//        print("\(imgURL)")
//        guard let imgData = try? Data(contentsOf: imgURL) else { return defaultImg!}
//        guard let image = UIImage(data: imgData) else { return defaultImg!}
//        return image
//    }
    
    func loadWeatherIcon(url: String){
        let imgURL = "http://openweathermap.org/img/wn/\(url)@2x.png"
        Alamofire.request(imgURL).responseData{ response in
            switch response.result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.weatherIcon.image = UIImage(data: data, scale:1)
                }
            case .failure(let error):
                print("error:",error)
            }
        }
    }
    
}
