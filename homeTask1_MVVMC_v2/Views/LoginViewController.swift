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
    
    func errorMessageDidChange(message: String) {
        if message.isEmpty {
            errorMessageLabel.text = ""
            errorMessageLabel.isHidden = true
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessageLabel.isHidden = false
                self?.errorMessageLabel.text = message
            }
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
