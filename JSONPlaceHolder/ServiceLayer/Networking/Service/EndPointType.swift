//
//  EndPointType.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 23/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
