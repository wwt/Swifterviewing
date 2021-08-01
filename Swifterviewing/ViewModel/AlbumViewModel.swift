//
//  AlbumViewModel.swift
//  Swifterviewing
//
//  Created by SOWJI on 01/08/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class AlbumViewModel {
    var albums = [Album]()
    var photos = [Photos]()
    let dispatchGroup = DispatchGroup()
    lazy var api = API()
    
    func fetchData(callback: @escaping (Error?) -> Void) {
        dispatchGroup.enter()
        DispatchQueue.main.async {
            self.api.getAlbums { [weak self] result in
                switch result {
                case .success(let albums):
                    self?.albums = albums
                case .failure(let error):
                    callback(error)
                }
                self?.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        DispatchQueue.main.async {
            self.api.getPhotos { [weak self] result in
                switch result {
                case .success(let photos):
                    self?.photos = photos
                case .failure(let error):
                    callback(error)
                }
                self?.dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main){
            callback(nil)
        }
    }
}
