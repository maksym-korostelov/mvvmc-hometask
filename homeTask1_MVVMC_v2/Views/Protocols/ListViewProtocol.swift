//
//  ListViewProtocol.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/6/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

protocol ListViewProtocol: class {
    var viewModel: ListViewModelProtocol? { get set }
    func itemsDidChange()
}
