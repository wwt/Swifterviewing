//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

//MARK: - API
struct API {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let photosEndpoint = "/photos" //returns photos and their album ID
    static let albumsEndpoint = "/albums" //returns an album, but without photos
    
    //MARK: - Progressbar Colors
    
    public enum Color {
        static let color1 = UIColor(red: 0, green: 0.2, blue: 0.38, alpha: 1)
        static let color2 = UIColor(red: 0.15, green: 0.61, blue: 0.83, alpha: 1)
    }
}
