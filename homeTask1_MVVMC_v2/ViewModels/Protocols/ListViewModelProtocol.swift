//
//  ListViewModelProtocol.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/6/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

protocol ListViewModelProtocol: AnyObject {
    var view: ListViewProtocol? { get set }
    var numberOfRows: Int { get }
    var randomList: [String] { get }
    var coordinator: ListCoordinatorProtocol? { get }
    func item(at index: IndexPath) -> String?
    func updateRandomList(with list: [String])
}
