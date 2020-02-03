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
            return model.userName
        }
        set {
            model.userName = newValue
        }
    }

    var password: String {
        get {
            return model.password
        }
        set {
            model.password = newValue
        }
    }

    fileprivate(set) var errorMessage: String = "" {
        didSet {
            view?.errorMessageDidChange()
        }
    }

    weak var view: LoginViewProtocol?
    private(set) weak var coordinator: LoginCoordinatorProtocol?
    private var model: LoginModelProtocol
    private var networkService: NetworkService

    init(model: LoginModelProtocol,
         networkServise: NetworkService,
         coordinator: LoginCoordinatorProtocol) {
        self.model = model
        networkService = networkServise
        self.coordinator = coordinator
    }

    func loginUser() {
        networkService.requestLoginData(
            userName: userName,
            password: password
        ) { [weak self] result in
            switch result {
            case .success:
                print("login success")
                self?.coordinator?.loginViewModelDidLogin()
            case let .failure(error):
                print("login failure")
                self?.errorMessage = error.localizedDescription
            }
        }
    }

    func passwordDidChange() {
        view?.passwordDidChange()
    }

    func userNameDidChange() {
        view?.userNameDidChange()
    }
}
