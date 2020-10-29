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
    
    let cityArray = ["台北市","新北市","桃園縣","新竹市","苗栗縣","台中市","彰化縣","雲林縣","南投縣","嘉義縣","台南市","高雄市","屏東縣","宜蘭縣","花蓮縣","台東縣"]
   
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    func setup(cellModel: CurrentWeatherCellModel, indexPath: IndexPath){
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderColor = UIColor.customBlue.cgColor
        self.contentView.layer.borderWidth = 5
        self.selectionStyle = .none
        
        let index = indexPath.section
        let cityWeather = cellModel.weatherList![index]
        self.cityNameLabel.text = "\(cityArray[index])"
        self.temperatureLabel.text = "\(cityWeather.main.temp)°C"
        self.feelLikeLabel.text = "\(cityWeather.main.feels_like)°C"
        self.humidityLabel.text = "\(cityWeather.main.humidity)%"
        self.sunriseLabel.text = self.timeintervalToString(interval: cityWeather.sys.sunrise)
        self.sunsetLabel.text = self.timeintervalToString(interval: cityWeather.sys.sunset)
        self.loadWeatherIcon(url: cityWeather.weather[0].icon)
        
        print("setup")
    }
    
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
    
    func timeintervalToString(interval: TimeInterval) -> String{
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let string = dateFormatter.string(from: date)
        return string
    }
    
}
