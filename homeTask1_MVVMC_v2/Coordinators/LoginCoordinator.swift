//
//  LoginCoordinator.swift
//  homeTask1_MVVMC
//
//  Created by Maksym Korostelov on 12/5/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import UIKit

final class LoginCoordinator: LoginCoordinatorProtocol {
    weak var delegate: LoginCoordinatorDelegate?

    func loginViewModelDidLogin() {
        delegate?.loginCoordinatorDidFinish()
    }

    private var presenter: UINavigationController
    func start() {
        let model = LoginModel()
        let viewModel = LoginViewModel(
            model: model,
            networkService: NetworkService(),
            coordinator: self
        )
        model.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            if let loginView = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginViewController {
                viewModel.view = loginView
                loginView.viewModel = viewModel
                self?.presenter.pushViewController(loginView, animated: true)
            }
        }
    }

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
}
