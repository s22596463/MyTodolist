//
//  WeatherModel.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/26.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    var lon: Double
    var current: WeatherCurrent
    var lat: Double
    var timezone: String
}

struct WeatherCurrent: Decodable {
    var dt: TimeInterval
    var sunrise: TimeInterval
    var weather: [WeatherWeather]
    var sunset: TimeInterval
    var temp: Double
    var feels_like: Double
    var humidity: Double
}

struct WeatherWeather: Decodable{
    var icon: String
    var main: String
    var description: String
    var id: Double
}
