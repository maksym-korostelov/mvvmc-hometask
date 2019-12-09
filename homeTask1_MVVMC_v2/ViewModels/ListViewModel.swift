//
//  ListViewModel.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/6/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

final class ListViewModel: ListViewModelProtocol {
    var networkServise: NetworkService?
    var numberOfRows: Int {
        return randomList?.count ?? 0
    }
    
    weak var view: ListViewProtocol?
    weak var coordinator: ListCoordinatorProtocol?
    var model: ListModelProtocol? {
        didSet {
            guard model != nil else { return }
            networkServise?.getRandomList { [weak self] result in
                switch result {
                case .success(let list):
                    self?.model?.randomList = list
                    self?.view?.itemsDidChange()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
    
    var randomList: [String]? {
        return model?.randomList
    }
    
    func item(at index: IndexPath) -> String {
        if let list = randomList , list.count > index.row {
            return list[index.row]
        }
        return ""
    }
}
