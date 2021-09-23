//
//  Album.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class Album: Codable {
  
  // MARK: Properties
  var userId : Int
  var id : Int
  var title : String
  
  var thumbnailUrl : String?
}
