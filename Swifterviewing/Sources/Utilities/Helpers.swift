//
//  Helpers.swift
//  Swifterviewing
//
//  Created by Bejgum Shirisha on 31/10/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

public class Helpers {
    
    /// utility method to replace any string
    /// - Parameters:
    ///   - title: orginal string
    ///   - findString: string to find
    ///   - replaceWith: string to replace
    /// - Returns: a utility method to replace any string
    class func getAlbumTitle(title:String,findString:String,replaceWith:String) -> String {
        return title.replacingOccurrences(of: findString, with:replaceWith)
    }
}
