//
//  AppCoordinator.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 26/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - AppCoordinator Singleton
    
    static let shared = AppCoordinator()
    
    private init() {}
    
    // MARK: - Private Properties
    
    private let rootViewController = UsersViewController()
    
    // MARK: - Supporting Functions
    
    func root(_ window: inout UIWindow?) {
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
    }
    
    func goToAlbumsViewController(from source: UIViewController, withUser id: Int) {
        let vc = AlbumsViewController(userId: id)
        source.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToPhotosViewController(from source: UIViewController, withAlbums id: Int) {
        let vc = PhotosViewController(albumId: id)
        source.navigationController?.pushViewController(vc, animated: true)
    }
}
