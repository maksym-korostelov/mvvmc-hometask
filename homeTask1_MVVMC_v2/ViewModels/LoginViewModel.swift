//
//  LoginViewModel.swift
//  homeTask1_MVVMC
//
//  Created by Maksym Korostelov on 12/4/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    var userName: String {
        get {
            return model?.userName ?? ""
        }
        set {
            model?.userName = newValue
        }
    }
    
    var password: String {
        get {
            return model?.password ?? ""
        }
        set {
            model?.password = newValue
        }
    }
    
    fileprivate(set) var errorMessage: String = "" {
        didSet {
            view?.errorMessageDidChange(message: errorMessage)
        }
    }
    
    var networkService: NetworkService?
    weak var view: LoginViewProtocol?
    weak var coordinator: LoginCoordinatorProtocol?
    var model: LoginModelProtocol?
    
    func loginUser() {
        networkService?.requestLoginData(userName: userName, password: password) { [weak self] result in
            switch result {
            case .success( _):
                print("login success")
                self?.coordinator?.loginViewModelDidLogin()
            case .failure(let error):
                print("login failure")
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
