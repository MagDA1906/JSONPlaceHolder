//
//  JSONPlaceholderEndPoint.swift
//
//  Created by Денис Магильницкий on 24/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//
//  https://jsonplaceholder.typicode.com
import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum JSONPlaceholderApi {
    case users
    case albums(id: Int)
    case photos(id: Int)
}

extension JSONPlaceholderApi: EndPointType {

    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://jsonplaceholder.typicode.com/"
        case .qa: return "https://qa.jsonplaceholder.typicode.com/"
        case .staging: return "https://staging.jsonplaceholder.typicode.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .users: return "users"
        case .albums(let id): return "users/\(id)/albums"
        case .photos(let id): return "albums/\(id)/photos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
