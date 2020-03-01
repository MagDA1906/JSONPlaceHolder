//
//  ServiceAPI.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 26/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

typealias ServiceAPICompletion = (_ success: Bool) -> ()
typealias Image = (UIImage)->()
typealias Users = UserApiResponse
typealias Albums = AlbumApiResponse
typealias Photos = PhotosApiResponse

enum FetchData {
    case users
    case albums
    case photos
}

// MARK: - ServiceAPIProtocol

protocol ServiceAPIProtocol {
    
    func fetch(_ id: Int?, _ fetchingData: FetchData, _ completion: @escaping ServiceAPICompletion)
    func getModelWith(_ description: FetchData, for indexPath: IndexPath) -> Any
    func getQuantityOfItemsBy(_ description: FetchData) -> Int
    func getImageBy(_ key: NSString, completion: @escaping Image)
}

class ServiceAPI: ServiceAPIProtocol {
    
    // MARK: - ServiceAPI Singleton
    
    static let shared = ServiceAPI()
    private init() {}
    
    // MARK: - Private Properties
    
    private let webImageServise: WebImageServiceProtocol = WebImageService()
    
    private var users   = [Users]()
    private var albums  = [Albums]()
    private var photos  = [Photos]()
    
    // MARK: - Public Functions
    
    func fetch(_ id: Int?, _ fetchingData: FetchData, _ completion: @escaping ServiceAPICompletion) {
        
        switch fetchingData {
        case .users:
            NetworkManager.shared.getUsers { (users, error) in
                if let error = error {
                    print(error)
                    completion(false)
                }
                if let users = users {
                    self.users = users
                    completion(true)
                }
            }
        case .albums:
            NetworkManager.shared.getAlbums(userId: id!) { (albums, error) in
                if let error = error {
                    print(error)
                    completion(false)
                }
                if let albums = albums {
                    self.albums = albums
                    completion(true)
                }
            }
        case .photos:
            NetworkManager.shared.getPhotos(albumId: id!) { (photos, error) in
                if let error = error {
                    print(error)
                    completion(false)
                }
                if let photos = photos {
                    self.photos = photos
                    completion(true)
                }
            }
        }
    }
    
    func getImageBy(_ key: NSString, completion: @escaping Image) {
        webImageServise.downloadImage(key) { (image, error) in
            if error != nil {
                print("Please check your network connection")
            }
            if let image = image {
                completion(image)
            }
        }
    }
    
    func getModelWith(_ description: FetchData, for indexPath: IndexPath) -> Any {
        switch description {
        case .users:
            return users[indexPath.row]
        case .albums:
            return albums[indexPath.row]
        case .photos:
            return photos[indexPath.row]
        }
    }
    
    func getQuantityOfItemsBy(_ description: FetchData) -> Int {
        switch description {
        case .users:
            return users.count
        case .albums:
            return albums.count
        case .photos:
            return photos.count
        }
    }
    
}
