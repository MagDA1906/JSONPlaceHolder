//
//  HTTPTask.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 23/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
