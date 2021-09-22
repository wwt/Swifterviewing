//
//  PhotosViewModel.swift
//  Swifterviewing
//
//  Created by Robert Daly on 9/22/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import Combine

class PhotoViewModel {
    
    var photos: [Photo] = []
    weak var delegate: ListViewModelDelegate?
    
    // MARK: - private vars
    private var bindings = Set<AnyCancellable>()
    private var api: API = API()
    private var start = 0
    private var limit = 100
    
    let albumId: Int

    init(albumId: Int){        
        self.albumId = albumId
        fetchPhotos()
    }
    
    // MARK: - helper method
    private func fetchPhotos(){
        let _ = api.useSessionPub(
            .photos(albumId),
            decodeTo: [Photo].self
        ) { [weak self] in
            self?.photos.append(contentsOf: $0)
            DispatchQueue.main.sync {
                self?.delegate?.onUpdate()
            }
        }
          
        start += limit
    }

    
}
