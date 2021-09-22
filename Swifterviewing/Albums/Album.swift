//
//  Album.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

struct Album: Decodable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id, title
    }
    
    var id: Int
    var title: String
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title).removeE()
        } catch {
            throw APIError.DecodingError
        }
        
    }
}
