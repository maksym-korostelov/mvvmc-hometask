//
//  LoginModelProtocol.swift
//  homeTask1_MVVMC
//
//  Created by Maksym Korostelov on 12/4/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

protocol LoginModelProtocol: class {
    var userName: String { get set }
    var password: String { get set }
}
