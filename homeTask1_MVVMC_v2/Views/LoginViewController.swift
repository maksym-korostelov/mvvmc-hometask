//
//  LoginViewController.swift
//  homeTask1_MVVMC
//
//  Created by Maksym Korostelov on 12/3/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewProtocol {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var viewModel: LoginViewModelProtocol!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        viewModel.loginUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshView()

        userNameField.addTarget(self, action: #selector(userNameFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordField.addTarget(self, action: #selector(passwordFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    func refreshView() {
        errorMessageLabel.text = ""
        errorMessageLabel.isHidden = true
    }
    
    func errorMessageDidChange() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            let errorMessage = self.viewModel.errorMessage
            self.errorMessageLabel.isHidden = errorMessage.isEmpty
            self.errorMessageLabel.text = errorMessage
        }
    }
    
    func userNameDidChange() {
        DispatchQueue.main.async { [weak self] in
            self?.userNameField.text = self?.viewModel.userName
            self?.refreshView()
        }
    }
    
    func passwordDidChange() {
        DispatchQueue.main.async { [weak self] in
            self?.passwordField.text = self?.viewModel.password
            self?.refreshView()
        }
    }
    
    @objc func userNameFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel?.userName = text
        }
        refreshView()
    }
    
    @objc func passwordFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel?.password = text
        }
        refreshView()
    }
}
