//
//  RxWeatherViewModel.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/11/6.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum RxWeatherError{
    case APIDisconnect
    case dataWrong
}

class RxWeatherViewModel{
    
    let service: NetworkManager = NetworkManager<RxWeatherRouter>()
    //var weather: RxWeatherModel?
    
    let loading = PublishSubject<Bool>()
    
    let error: PublishSubject<RxWeatherError> = PublishSubject()
    let weatherRelay = BehaviorRelay<[daily]>(value: [])
    lazy var weather : Observable<[daily]> = {
        return weatherRelay.asObservable()
    }()
    
    //let weather = Observable<[daily]>()
    

    
    func getWeather(lat:Double,lon:Double){
        
        let completion:(RxWeatherModel?,String,Error?,Bool)-> Void = { data, msg, error, success in
            self.loading.onNext(true)
            if success {
                self.weatherRelay.accept(data?.daily ?? [])
                self.loading.onNext(false)
                print(msg)
                print(data)
            }else{
                print(error)
            }
        }
        
        service.requestData(router: RxWeatherRouter.getWeekWeather(lat: lat, lon: lon), completion: completion)
    }
    
}
