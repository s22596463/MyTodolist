//
//  RxSignUpViewModel.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/11/23.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RxSignUpViewModel{
    
    let userName = PublishSubject<String>()
    let userNameValid: Driver<Bool>
    
    let password = PublishSubject<String>()
    let passwordValid: Driver<Bool>
    
    let signUpValid: Driver<Bool>
    let signUpButton = PublishSubject<Void>()
    
    init() {
        
        userNameValid = userName.map{
            $0.count >= 5
        }.asDriver(onErrorJustReturn: false)
        
        passwordValid = password.map{
            $0.count >= 5
        }.asDriver(onErrorJustReturn: false)
        
        signUpValid = Driver.combineLatest(userNameValid, passwordValid){
            return $0 && $1
        }
        
        
    }
    
    //隨機發送成功或失敗
    func signUp() -> Observable<Bool>{
        .create{ observer -> Disposable in
            let number = Int.random(in: 0...10)
            if number <= 5 {
                observer.onNext(true)
            }else{
                observer.onNext(false)
            }
            return Disposables.create()
        }
    }
    
    
    
}
