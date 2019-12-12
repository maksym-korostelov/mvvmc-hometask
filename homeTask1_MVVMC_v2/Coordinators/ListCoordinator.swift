//
//  ListCoordinator.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/6/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import UIKit

final class ListCoordinator: ListCoordinatorProtocol {
    weak var delegate: LoginCoordinatorDelegate?
    private var presenter: UINavigationController
    
    func start() {
        let model = ListModel()
        let viewModel = ListViewModel(
            model: model,
            networkServise: NetworkService(),
            coordinator: self)
        model.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            let storyboard = UIStoryboard(name: "List", bundle: nil)
            if let listView = storyboard.instantiateViewController(withIdentifier: "List") as? ListTableViewController {
                viewModel.view = listView
                listView.viewModel = viewModel
                self?.presenter.pushViewController(listView, animated: true)
            }
        }
    }
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
}
