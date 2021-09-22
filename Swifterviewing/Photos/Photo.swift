//
//  Photo.swift
//  Swifterviewing
//
//  Created by Robert Daly on 9/22/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct Photo: Codable, Hashable {
    var id: Int
    var title: String
    var thumbnailUrl: String
}
