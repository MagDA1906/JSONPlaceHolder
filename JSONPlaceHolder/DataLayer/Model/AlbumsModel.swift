//
//  AlbumsModel.swift
//  JSONPlaceHolder
//
//  Created by Денис Магильницкий on 26/02/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import Foundation

struct AlbumApiResponse: Codable {
    let userId: Int
    let id: Int
    let title: String
}
