//
//  PhotosModel.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 26/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import Foundation

struct PhotosApiResponse: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
}
