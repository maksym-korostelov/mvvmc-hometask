//
//  AppCoordinatorProtocol.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/9/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

protocol AppCoordinatorProtocol: CoordinatorProtocol {
    func start()
    func startLogin(with loginCoordinator: LoginCoordinatorProtocol)
    func startList(with listCoordinator: ListCoordinatorProtocol)
}
