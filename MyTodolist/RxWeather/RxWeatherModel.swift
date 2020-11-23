//
//  RxWeatherModel.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/11/6.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation

enum city{
    case Taipei
    case NewTaipei
    
    func getLocation() -> [String:Double]{
        switch self {
        case .Taipei:
            return ["lat":25,"lon":121]
        case .NewTaipei:
            return ["lat":24,"lon":122]
        }
    }
}

struct RxWeatherModel: Decodable{
    var daily: [daily]
}

struct daily: Decodable{
    var dt: TimeInterval
    var temp: temp
    var humidity: Double
}

struct temp: Decodable {
    var day: Double
//    var min: Double
//    var max: Double
//    var night: Double
//    var eve: Double
//    var morn: Double
}
