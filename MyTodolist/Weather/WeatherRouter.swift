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
    case getCurrentWeather
}

extension WeatherRouter: RouterType{
    var baseURL: String {
        switch self {
        case .getCurrentWeather:
            return "https://api.openweathermap.org/data/2.5/group?"
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
        case .getCurrentWeather:
            let groupCityid = "1668338,1668341,1925256,1675151,1671971,1668399,1679136,1671564,1665194,1678813,1668352,1673820,1670479,1674197,1674502,1668295"
            return ["id":groupCityid,
                    "appid":"7b1c4904878a7746d7a6d5b237549b4c",
                    "units":"metric"]
        }
    }
    
    var header: HTTPHeaders? {
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        return header
    }
    
    
}
