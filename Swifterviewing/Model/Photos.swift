//
//  Photos.swift
//  Swifterviewing
//
//  Created by SOWJI on 01/08/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct Photos: Decodable {
    var albumId: Int
    var title: String?
    var thumbnailUrl: String?
}
