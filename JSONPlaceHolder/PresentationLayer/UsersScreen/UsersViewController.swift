//
//  ViewController.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 23/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var tableView: UITableView!
    private var spinner: UIActivityIndicatorView!
    
    private let footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        spinner.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureSpinner()
        configureTableView()
        fetchUsers()
    }

}

// MARK: - Private Functions

private extension UsersViewController {
    
    func fetchUsers() {
        
        ServiceAPI.shared.fetch(nil, .users) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.spinner.stopAnimating()
                    self.spinner.hidesWhenStopped = true
                }
            }
        }
    }
    
    func configureNavigationItem() {
        navigationItem.title = "Users"
    }
    
    func configureTableView() {
        
        tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.reuseId)
        
        view.addSubview(tableView)
        
        tableView.frame = view.frame
        tableView.tableFooterView = footerView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // tableView constraints
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func configureSpinner() {
        spinner = UIActivityIndicatorView()
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = UIColor.darkGray
    }
    
    func userCellForIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.reuseId, for: indexPath)
        guard let userCell = cell as? UsersTableViewCell else {
            return cell
        }
        
        let user = ServiceAPI.shared.getModelWith(.users, for: indexPath) as! Users
        userCell.textLabel?.text = user.name
        
        return userCell
    }
}

// MARK: - UITableViewDelegate

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = ServiceAPI.shared.getModelWith(.users, for: indexPath) as! Users
        
        AppCoordinator.shared.goToAlbumsViewController(from: self, withUser: user.id)
    }
}

// MARK: - UITableViewDataSource

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceAPI.shared.getQuantityOfItemsBy(.users)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return userCellForIndexPath(indexPath)
    }
}
