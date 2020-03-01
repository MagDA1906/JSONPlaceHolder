//
//  UserModel.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 24/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import Foundation

struct UserApiResponse: Codable {
    let id: Int
    let name: String
    let userName: String
    let eMail: String
    let address: Address
    let phone: String
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case eMail = "email"
        case address
        case phone
        case website
    }
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
}
