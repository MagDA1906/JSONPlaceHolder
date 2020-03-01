//
//  PhotosViewController.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 01/03/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    // MARK: - Initialization
    
    var albumId: Int
    
    init(albumId: Int) {
        self.albumId = albumId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties
    
    private var tableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPhotos()
        configureNavigationItem()
        configureTableView()
        
    }
}

// MARK: - Private Functions

private extension PhotosViewController {
    
    func fetchPhotos() {
        
        ServiceAPI.shared.fetch(albumId, .photos) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    
    // Configure PhotosTableViewCell
    func photoCellForIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.nibName, for: indexPath)
        
        guard let photoCell = cell as? PhotosTableViewCell else {
            return cell
        }
        
        let photo = ServiceAPI.shared.getModelWith(.photos, for: indexPath) as! Photos
        
        photoCell.configureSelfUsingModel(photo)
        return photoCell
    }
    
    func configureTableView() {
        
        tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let photoCellReuseId = PhotosTableViewCell.nibName
        let photoCellNib = UINib(nibName: photoCellReuseId, bundle: nil)
        
        tableView.register(photoCellNib, forCellReuseIdentifier: photoCellReuseId)
        
        view.addSubview(tableView)
        
        tableView.frame = view.frame
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // tableView constraints
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func configureNavigationItem() {
        navigationItem.title = "Photos"
    }
}

// MARK: - UITableViewDelegate

extension PhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension PhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceAPI.shared.getQuantityOfItemsBy(.photos)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return photoCellForIndexPath(indexPath)
    }
}
