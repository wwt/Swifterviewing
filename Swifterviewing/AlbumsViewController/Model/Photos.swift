//
//  Photos.swift
//  Swifterviewing
//
//  Created by Dharma Teja Kanneganti on 10/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

//MARk: - Photos Model
struct Photos : Codable
{
    var albumId : Int
    var id : Int
    var title : String?
    var url : String?
    var thumbnailUrl : String?
    
    enum CodingKeys: String, CodingKey
    {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
}
