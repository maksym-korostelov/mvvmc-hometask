//
//  AppCoordinator.swift
//  homeTask1_MVVMC
//
//  Created by Maksym Korostelov on 12/5/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import UIKit

final class AppCoordinator: AppCoordinatorProtocol {
    var window: UIWindow!
    private let rootViewController: UINavigationController = UINavigationController()
    private var loginCoordinator: LoginCoordinatorProtocol?
    private var listCoordinator: ListCoordinatorProtocol?
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        let loginCoordinator = LoginCoordinator(presenter: rootViewController)
        startLogin(with: loginCoordinator)
    }
    
    func startLogin(with loginCoordinator: LoginCoordinatorProtocol) {
        self.loginCoordinator = loginCoordinator
        loginCoordinator.delegate = self
        loginCoordinator.start()
    }
    
    func startList(with listCoordinator: ListCoordinatorProtocol) {
        self.listCoordinator = listCoordinator
        listCoordinator.delegate = self
        listCoordinator.start()
    }
}

extension AppCoordinator: LoginCoordinatorDelegate {
    func loginCoordinatorDidFinish() {
        let listCoordinator = ListCoordinator(presenter: rootViewController)
        startList(with: listCoordinator)
    }
}
