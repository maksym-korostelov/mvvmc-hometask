//
//  LoginModel.swift
//  homeTask1_MVVMC
//
//  Created by Maksym Korostelov on 12/4/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

final class LoginModel: LoginModelProtocol {
    weak var viewModel: LoginViewModelProtocol?
    var userName: String = "" {
        didSet {
            viewModel?.userNameDidChange()
        }
    }

    var password: String = "" {
        didSet {
            viewModel?.passwordDidChange()
        }
    }
}
