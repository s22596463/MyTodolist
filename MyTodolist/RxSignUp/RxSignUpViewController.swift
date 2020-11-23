//
//  RxSignin.swift
//  MyTodolist
//
//  Created by 謝宛軒 on 2020/11/23.
//  Copyright © 2020 謝宛軒. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RxSignUpViewController: UIViewController{
    
    private let viewModel = RxSignUpViewModel()
    private let disposedBag = DisposeBag()
    
    private let userName : UITextField = {
        let tf = UITextField()
        tf.placeholder = "  input user name"
        tf.tintColor = UIColor.gray
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        //tf.keyboardType = .emailAddress
        //tf.returnKeyType = .done
        //tf.delegate = self
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let unvalidName: UILabel = {
        let label = UILabel()
        label.text = "  need five characters at least"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.red
        label.isHidden = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let password : UITextField = {
        let tf = UITextField()
        tf.placeholder = "  input password"
        tf.tintColor = UIColor.gray
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.isEnabled = false
        //tf.keyboardType = .emailAddress
        //tf.returnKeyType = .done
        //tf.delegate = self
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let unvalidPassword: UILabel = {
        let label = UILabel()
        label.text = "  need five characters at least"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.red
        label.isHidden = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let SignUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("SignUp!", for: .normal)
        btn.backgroundColor = UIColor.customBlue
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.tintColor = UIColor.black
        btn.isEnabled = false
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        setupUI()
        setUpNav()
        setupBinding()
    }
    
    func setUpNav(){
        self.navigationItem.title = "SignUp View using RxSwift"
        self.navigationController?.navigationBar.barTintColor = .customBlue
    }
    
    func setupUI(){
        self.view.addSubview(userName)
        userName.snp.makeConstraints{ item in
            item.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            item.centerX.equalToSuperview()
            item.height.equalTo(40)
            item.width.equalTo(250)
        }
        
        self.view.addSubview(unvalidName)
        unvalidName.snp.makeConstraints{ item in
            item.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(75)
            item.left.equalTo(userName.snp.left)
        }
        
        self.view.addSubview(password)
        password.snp.makeConstraints{ item in
            item.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(110)
            item.centerX.equalToSuperview()
            item.height.equalTo(40)
            item.width.equalTo(250)
        }
        self.view.addSubview(unvalidPassword)
        unvalidPassword.snp.makeConstraints{ item in
            item.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(155)
            item.left.equalTo(password.snp.left)
        }
        
        self.view.addSubview(SignUpButton)
        SignUpButton.snp.makeConstraints{ item in
            item.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(190)
            item.centerX.equalToSuperview()
            item.height.equalTo(40)
            item.width.equalTo(250)
        }
        
    }
    
    func setupBinding(){
        userName.rx.text.orEmpty.throttle(0.3, scheduler: MainScheduler.instance).bind(to: viewModel.userName).disposed(by: disposedBag)
        //viewModel.userName.bind(to: userName.rx.text.orEmpty).disposed(by: disposedBag)
        
        viewModel.userNameValid.drive(onNext:{ valid in
            if valid {
                self.unvalidName.isHidden = true
            }else{
                self.unvalidName.isHidden = false
            }
        }).disposed(by: disposedBag)
        
        viewModel.userNameValid.drive(password.rx.isEnabled).disposed(by: disposedBag)
        
        password.rx.text.orEmpty.throttle(0.3, scheduler: MainScheduler.instance).bind(to: viewModel.password).disposed(by: disposedBag)
        
        viewModel.passwordValid.drive(onNext:{ valid in
            if valid {
                self.unvalidPassword.isHidden = true
            }else{
                self.unvalidPassword.isHidden = false
            }
        }).disposed(by: disposedBag)
        
        viewModel.signUpValid.drive(SignUpButton.rx.isEnabled).disposed(by: disposedBag)
        
        SignUpButton.rx.tap.flatMapLatest{
            self.viewModel.signUp()
        }.subscribe(onNext:{ success in
            if success {
                self.showMessage(text: " SignUp Success !")
            }else{
                self.showMessage(text: " SignUp Fail !")
            }
        }).disposed(by: disposedBag)
        
    }
    
    func showMessage(text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
