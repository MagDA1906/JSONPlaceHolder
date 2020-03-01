//
//  AlbumsViewController.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 29/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    // MARK: - Initialization
    
    var userId: Int
    
    init(userId: Int) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

private extension AlbumsViewController {
    
    func fetchUsers() {
        
        ServiceAPI.shared.fetch(userId, .albums) { (success) in
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
        navigationItem.title = "Albums"
    }
    
    func configureTableView() {
        
        tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: AlbumsTableViewCell.reuseId)
        
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
    
    func albumCellForIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumsTableViewCell.reuseId, for: indexPath)
        guard let albumCell = cell as? AlbumsTableViewCell else {
            return cell
        }
        
        let album = ServiceAPI.shared.getModelWith(.albums, for: indexPath) as! Albums
        albumCell.albumTitleLabel.text = album.title
        
        return albumCell
    }
}

// MARK: - UITableViewDelegate

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let album = ServiceAPI.shared.getModelWith(.albums, for: indexPath) as! Albums
        
        AppCoordinator.shared.goToPhotosViewController(from: self, withAlbums: album.id)
    }
}

// MARK: - UITableViewDataSource

extension AlbumsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceAPI.shared.getQuantityOfItemsBy(.albums)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return albumCellForIndexPath(indexPath)
    }
}
