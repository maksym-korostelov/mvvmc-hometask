//
//  ListViewModel.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/6/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import Foundation

final class ListViewModel: ListViewModelProtocol {
    var numberOfRows: Int {
        return randomList.count
    }

    var randomList: [String] {
        return model.randomList
    }

    weak var view: ListViewProtocol?

    private(set) weak var coordinator: ListCoordinatorProtocol?
    private var model: ListModelProtocol
    private var networkServise: NetworkService

    init(model: ListModelProtocol,
         networkServise: NetworkService,
         coordinator: ListCoordinatorProtocol) {
        self.model = model
        self.networkServise = networkServise
        self.coordinator = coordinator
        loadData()
    }

    func item(at index: IndexPath) -> String? {
        if randomList.count > index.row {
            return randomList[index.row]
        }
        return nil
    }

    func updateRandomList(with _: [String]) {
        view?.itemsDidChange()
    }
}

private extension ListViewModel {
    private func loadData() {
        networkServise.getRandomList { [weak self] result in
            switch result {
            case let .success(list):
                self?.model.randomList = list
                self?.view?.itemsDidChange()
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
