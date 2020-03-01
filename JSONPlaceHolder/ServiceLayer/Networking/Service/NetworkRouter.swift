//
//  NetworkRouter.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 24/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
