//
//  ListCoordinatorProtocol.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/9/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

protocol ListCoordinatorProtocol: CoordinatorProtocol {
    var delegate: LoginCoordinatorDelegate? { get set }
}
