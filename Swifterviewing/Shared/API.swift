//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import Combine
import UIKit

struct API{
    
    func useSessionPub<T: Decodable>(
        _ endpoint: Endpoint,
        decodeTo: T.Type,
        closure: @escaping (T)->()
    ) -> AnyCancellable? {
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
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { closure($0) }
            )
    }
    
    func fetchImage(
        _ urlString: String,
        closure: @escaping (UIImage)->()
    ) -> AnyCancellable? {
        guard let url = URL(string: urlString) else { return nil }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map {
                guard let image = UIImage(data: $0.data)
                    else { fatalError("Image couldn't be loaded :(") }
                return image
            }
            .sink(receiveCompletion: { print("Image: \($0)")}) {
                closure($0)
            }
    }
}

enum Endpoint {
    case albums(Int, Int)
    case photos(Int)
    
    static let scheme = "https"
    static let host = "jsonplaceholder.typicode.com"
    static let photos = "/photos" //returns photos and their album ID
    static let albums = "/albums" //returns an album, but without photos
    
    func getComponenets() -> URL? {
        
        var components = URLComponents()
        components.scheme = Endpoint.scheme
        components.host = Endpoint.host
        
        switch self {
        case .albums(let start, let limit):
            components.path = Endpoint.albums
            components.queryItems = [
                URLQueryItem(name: "_start", value: String(start)),
                URLQueryItem(name: "_limit", value: String(limit))
            ]
            break
        case .photos(let id):
            components.path = Endpoint.albums + "/\(id)" + Endpoint.photos
            break
        }
        
        return components.url
    }
}

enum APIError: Error {
    case URLResultError
    case DecodingError
}
