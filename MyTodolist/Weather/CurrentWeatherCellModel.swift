//
//  CurrentWeatherCellModel.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/28.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation

class CurrentWeatherCellModel{
    
    var temperature: Double = 0
    var feelLike: Double = 0
    var humidity: Double = 0
    var sunrise: String = ""
    var sunset: String = ""
    var weatherIconURL: String = ""
    
    let service: NetworkManager = NetworkManager<WeatherRouter>()
    
    func getCurrentWeather(lat: Double,lon: Double, completion: @escaping (CurrentWeatherCellModel)-> Void ){
        let completion: (WeatherModel?, String, Error?, Bool) -> Void = { data, msg, error, success in
            if let data = data, success {
                print(data)
                self.temperature = data.current.temp
                self.feelLike = data.current.feels_like
                self.humidity = data.current.humidity
                self.sunrise = "\(self.timeintervalToString(interval: data.current.sunrise))"
                self.sunset = "\(self.timeintervalToString(interval: data.current.sunset))"
                self.weatherIconURL = "\(data.current.weather[0].icon)"
                print("weatherIconURL\(data.current.weather[0].icon)")
                completion(self)
                
            }else{
                print(error)
            }
        }
        service.requestData(router: .getCurrentWeather(lat: lat, lon: lon), completion: completion)
    }
    
    func timeintervalToString(interval: TimeInterval) -> String{
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let string = dateFormatter.string(from: date)
        return string
    }
    
    
}
