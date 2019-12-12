//
//  ListModel.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/6/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

final class ListModel: ListModelProtocol {
    weak var viewModel: ListViewModelProtocol?
    var randomList: [String] = [] {
        didSet {
            viewModel?.updateRandomList(with: randomList)
        }
    }
}
