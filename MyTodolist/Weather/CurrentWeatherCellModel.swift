//
//  CurrentWeatherCellModel.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/28.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation

class CurrentWeatherCellModel{
    
    let service: NetworkManager = NetworkManager<WeatherRouter>()
    var weatherList: [WeatherList]?
    
    func getCurrentWeather(completion: @escaping ()-> Void ){
            let completion: (WeatherModel?, String, Error?, Bool) -> Void = { data, msg, error, success in
                if let data = data, success {
                    self.weatherList = data.list
                    completion()
                }else{
                    print(error)
                }
            }
        service.requestData(router: .getCurrentWeather, completion: completion)
        }
    
    func timeintervalToString(interval: TimeInterval) -> String{
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let string = dateFormatter.string(from: date)
        return string
    }
    
    
}
