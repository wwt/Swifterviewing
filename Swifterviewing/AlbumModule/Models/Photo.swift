//
//  Photo.swift
//  Swifterviewing
//
//  Created by Bejgum Shirisha on 31/10/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct Photo: Codable {
    
        var albumId: Int
        var id: Int
        var title: String?
    var url: String?
    var thumbnailUrl: String?
}
