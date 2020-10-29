//
//  WeatherRouter.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/26.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRouter{
    case getCurrentWeather(lat:Double,lon:Double)
}

extension WeatherRouter: RouterType{
    var baseURL: String {
        switch self {
        case .getCurrentWeather:
            return "https://api.openweathermap.org/data/2.5/onecall?"
        }
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return ""
        }
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var param: [String : Any]? {
        switch self {
        case let .getCurrentWeather(lat, lon):
            return ["exclude":"minutely,hourly,daily",
                    "appid":"7b1c4904878a7746d7a6d5b237549b4c",
                    //"lang":"zh_tw",
                    "units":"metric",
                    "lon":lon,
                    "lat":lat]
        }
    }
    
    var header: HTTPHeaders? {
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        return header
    }
    
    
}
