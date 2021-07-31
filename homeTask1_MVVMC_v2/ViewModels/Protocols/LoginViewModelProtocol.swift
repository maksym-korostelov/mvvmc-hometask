//
//  LoginViewModelProtocol.swift
//  homeTask1_MVVMC
//
//  Created by Maksym Korostelov on 12/4/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    var userName: String { get set }
    var password: String { get set }
    var errorMessage: String { get }
    var coordinator: LoginCoordinatorProtocol? { get }
    var view: LoginViewProtocol? { get set }
    func loginUser()
    func passwordDidChange()
    func userNameDidChange()
}
