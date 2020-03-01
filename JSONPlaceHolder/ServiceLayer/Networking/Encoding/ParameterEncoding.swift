//
//  ParameterEncoding.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 23/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "parameter encoding failed."
    case missingURL = "URL is nil."
}

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
