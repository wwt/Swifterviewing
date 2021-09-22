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

    let albumId: Int
    
    var photos: [Photo] = []
    weak var delegate: ListViewModelDelegate?
    
    // MARK: - private vars
    private var bindings = Set<AnyCancellable>()
    private var api: API = API<Photo>()
    private var start = 0
    private var limit = 100
    
    init(albumId: Int){        
        self.albumId = albumId
        fetchPhotos()
    }
    
    // MARK: - helper method
    private func fetchPhotos(){
        api.getSessionPublisher(
            .photos(albumId),
            bindings: &bindings
        ) { [weak self] in
            let photos = $0 as [Photo]
            self?.photos.append(contentsOf: photos)
            DispatchQueue.main.sync {
                self?.delegate?.onUpdate()
            }
        }
          
        start += limit
    }

    
}
