//
//  WeatherModel.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/26.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    var cnt: Int
    var list: [WeatherList]
}

struct WeatherList: Decodable {
    var sys: WeatherSys
    var weather: [WeatherWeather]
    var main: WeatherMain
}

struct WeatherSys: Decodable {
    var sunrise: TimeInterval
    var sunset: TimeInterval
}


struct WeatherWeather: Decodable {
    var icon: String
    var main: String
    var description: String
    var id: Double
}

struct WeatherMain: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var humidity: Double
}
