//
//  NetworkManager.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 24/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    static let environment: NetworkEnvironment = .production
    static let JSONPlaceholderAPIKey = ""
    private let router = Router<JSONPlaceholderApi>()
    
    func getUsers(completion: @escaping (_ users: [UserApiResponse]?, _ error: String?)->()) {
        router.request(.users) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([UserApiResponse].self, from: responseData)
                        dump(apiResponse)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getAlbums(userId: Int, completion: @escaping (_ albums: [AlbumApiResponse]?, _ error: String?)->()) {
        router.request(.albums(id: userId)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([AlbumApiResponse].self, from: responseData)
                        dump(apiResponse)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getPhotos(albumId: Int, completion: @escaping (_ albums: [PhotosApiResponse]?, _ error: String?)->()) {
        router.request(.photos(id: albumId)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([PhotosApiResponse].self, from: responseData)
                        dump(apiResponse)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getImage(completion: @escaping (_ image: UIImage?, _ error: String?) -> ()) {
        
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
