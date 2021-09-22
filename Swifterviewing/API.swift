//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import Combine

struct API {
    func getSessionPublisher(_ endpoint: Endpoint ) -> Publishers.TryMap<URLSession.DataTaskPublisher, Data>? {
        guard let url = endpoint.getComponenets() else { return nil }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                
                return element.data
            }
    }
}

enum Endpoint {
    case albums(Int, Int)
    case photos(Int)
    
    static let host = "https://jsonplaceholder.typicode.com"
    static let photosEndpoint = "/photos" //returns photos and their album ID
    static let albumsEndpoint = "/albums" //returns an album, but without photos
    
    func getComponenets() -> URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        
        switch self {
        case .albums(let start, let limit):
            components.path = "/albums"
            components.queryItems = [
                URLQueryItem(name: "_start", value: String(start)),
                URLQueryItem(name: "_limit", value: String(limit))
            ]
            break
        case .photos(let _):
            // TODO: setup code
            break
        }
        
        return components.url
    }
}


// TODO: error handling!!
//extension API {
//    enum AlbumError: Error {
//        case URLResultError
//    }
//}
