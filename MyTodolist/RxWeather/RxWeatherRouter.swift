//
//  RxWeatherRouter.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/11/6.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum RxWeatherRouter{
    case getWeekWeather(lat:Double,lon:Double)
}

extension RxWeatherRouter: RouterType{
    var baseURL: String {
        switch self {
        case .getWeekWeather:
            return "https://api.openweathermap.org/data/2.5/onecall?"
        
        }
    }
    
    var path: String {
        switch self {
        case .getWeekWeather:
            return ""
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.default
    }
    
    var param: [String : Any]? {
        switch self {
        case let .getWeekWeather(lat,lon):
            return ["lat":lat,
                    "lon":lon,
                    "exclude":"current,minutely,hourly",
                    "appid":"7b1c4904878a7746d7a6d5b237549b4c",
                    "units":"metric"]
        }
    }
    
    var header: HTTPHeaders? {
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        return header
    }
    
    
}
