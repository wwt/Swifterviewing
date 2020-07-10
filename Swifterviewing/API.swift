//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

<#ClassOrStruct#> API {
    let baseURL = "https://jsonplaceholder.typicode.com/"
    let photosEndpoint = "/photos" //returns photos and their album ID
    let albumsEndpoint = "/albums" //returns an album, but without photos
    
    func getAlbums(callback: (Result<Album, AlbumError>) -> Void) {
    }
}

extension API {
    enum AlbumError: Error {
        case <#SomeRealisticErrorThing#>
    }
}
