//
//  ListTableViewController.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/6/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, ListViewProtocol {
    func itemsDidChange() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    var viewModel: ListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "randomDataReuseIdentifier", for: indexPath)

        cell.textLabel?.text = viewModel?.item(at: indexPath)
        
        return cell
    }
}
