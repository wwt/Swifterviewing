//
//  Album.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

//Albums Model
struct Album : Codable {
    var userId : Int
    var id : Int
    var title : String?
    
    enum CodingKeys: String, CodingKey
    {
        case userId
        case id
        case title
    }
}
