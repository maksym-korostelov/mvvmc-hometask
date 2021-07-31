//
//  LoginViewProtocol.swift
//  homeTask1_MVVMC
//
//  Created by Maksym Korostelov on 12/4/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    var viewModel: LoginViewModelProtocol! { get set }
    func errorMessageDidChange()
    func passwordDidChange()
    func userNameDidChange()
}
