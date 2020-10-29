//
//  NetworkManager.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/10/26.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import Alamofire

protocol RouterType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var param: [String: Any]? { get }
    var header: HTTPHeaders? { get }
}

extension RouterType{
    var onError: Bool { // MARK: - If true should custom error handler self
        return false
    }
    
    var session: SessionManager { //MARK: - SessionObj's life cycle should over request block
        return MySessionManager
    }
}

let MySessionManager: SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 60
    configuration.timeoutIntervalForResource = 60
    
    let manager = Alamofire.SessionManager(configuration: configuration)
    return manager
}()


class NetworkManager<R: RouterType>{
    
    func requestData<D: Decodable>(router: R,completion: @escaping(D?,String,Error?,Bool) -> Void){
        
        let url = router.baseURL + router.path
        router.session.request(url,
                               method:router.method,
                               parameters: router.param,
                               encoding: router.encoding,
                               headers: router.header).validate().responseData{ response in
            switch response.result {
            case .success(let data):
                do{
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(D.self, from: data)
                    //print(result)
                    completion(result,"Decoding Success",nil,true)
                }catch let error{
                    completion(nil,"Decoding Error",error,false)
                }
            
            case .failure(let error):
                print(error)
            completion(nil,"Error",error,false)
        }
        
    }
}

}
