//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct API {
    let baseURL = "https://jsonplaceholder.typicode.com/%@"
    // For testcases declared endpoints as var
    var photosEndpoint = "photos" //returns photos and their album ID
    var albumsEndpoint = "albums" //returns an album, but without photos
    typealias albumHandler = (Result<[Album], Error>) -> Void
    typealias photosHandler = (Result<[Photos], Error>) -> Void
    
    // Can move these methods to viewmodel itself but as intially it is given under API using the same
    func getAlbums(callback: @escaping albumHandler) {
        if let albumURL = URL(string: String(format: baseURL, albumsEndpoint)) {
            DataManager.HTTPGetRequest(url: albumURL) { (result: Result<[Album], Error>) in
                switch result {
                case .success(let albums):
                    callback(.success(albums))
                case .failure(let error):
                    callback(.failure(error))
                }
            }
        }
    }
    
    func getPhotos(callback: @escaping photosHandler) {
        if let photosURL = URL(string: String(format: baseURL, photosEndpoint)) {
            DataManager.HTTPGetRequest(url: photosURL) { (result: Result<[Photos], Error>) in
                switch result {
                case .success(let photos):
                    callback(.success(photos))
                case .failure(let error):
                    callback(.failure(error))
                }
            }
        }
    }
}
