//
//  AlbumViewModel.swift
//  Swifterviewing
//
//  Created by Robert Daly on 9/20/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol ListViewModelDelegate: AnyObject {
    func onUpdate()
}

final class AlbumViewModel {
    
    var albums: [Album] = []
    weak var delegate: ListViewModelDelegate?
    
    // MARK: - private vars
    private var albumsApi: API = API()
    private var cancellables = [Int: AnyCancellable]()
    private var start = 0
    private var limit = 100

    init(){
        fetchAlbums()
    }
    
    // MARK: - helper method
    private func fetchAlbums(){
        cancellables[4000] = albumsApi.useSessionPub(
            .albums(start, limit),
            decodeTo: [Album].self
        ) { [weak self] in
            self?.albums.append(contentsOf: $0)
            self?.cancellables[4000] = nil
            DispatchQueue.main.sync {
                self?.delegate?.onUpdate()
            }
        }
    
        start += limit
    }
            
    func fetchThumbNail(_ id: Int, onFinish: @escaping (UIImage) -> ()){
        cancellables[id] = albumsApi.useSessionPub(
            .photos(id),
            decodeTo: [Photo].self
        ) {[weak self] in
            guard let thumbnailUrl = $0.first?.thumbnailUrl else { return }
            self?.cancellables[id] = self?.albumsApi
                .fetchImage(thumbnailUrl){[weak self] image in
                    self?.cancellables[id] = nil
                    DispatchQueue.main.sync {
                        onFinish(image)
                    }
                }
        }
    
    }
    
    func cancelWithId(_ id: Int) {
        cancellables[id]?.cancel()
        cancellables[id] = nil
    }
    
}
