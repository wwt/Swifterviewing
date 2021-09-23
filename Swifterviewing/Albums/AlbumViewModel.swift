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
    private var cancellables = ThreadSafeDictionary(
        dict: [Int: (
            image: UIImage?,
            cancellable: AnyCancellable?
        )]()
    )
    private var albumsApi: API = API()
    private var start = 0
    private var limit = 100

    init(){
        fetchAlbums()
    }
    
    
    // MARK: - helper method
    private var albumFetchCancellable: AnyCancellable?
    private func fetchAlbums(){
        albumFetchCancellable = albumsApi.useSessionPub(
            .albums(start, limit),
            decodeTo: [Album].self
        ) { [weak self] in
            self?.albums.append(contentsOf: $0)
            self?.albumFetchCancellable = nil
            DispatchQueue.main.sync {
                self?.delegate?.onUpdate()
            }
        }
    
        start += limit
    }
            
    func fetchThumbNail(_ id: Int, onFinish: @escaping (UIImage) -> ()){

        if let image = cancellables[id]?.image {
            onFinish(image)
            return
        }
        
        let cancellable = albumsApi.useSessionPub(
            .photos(id),
            decodeTo: [Photo].self
        ) {[weak self] in
            guard let thumbnailUrl = $0.first?.thumbnailUrl else { return }
            let innerCancellable = self?.albumsApi
                .fetchImage(thumbnailUrl){[weak self] image in
                    self?.cancellables[id]?.image = image
                    DispatchQueue.main.sync {
                        onFinish(image)
                    }
                }
            if self?.cancellables[id] == nil {
                self?.cancellables[id] = (image: nil, cancellable: innerCancellable)
            } else {
                self?.cancellables[id]?.cancellable = innerCancellable
            }
        }
        if cancellables[id] == nil {
            cancellables[id] = (image: nil, cancellable: cancellable)
        } else {
            cancellables[id]?.cancellable = cancellable
        }
    
    }
    
    func cancelWithId(_ id: Int) {
        cancellables[id]?.cancellable?.cancel()
        cancellables.removeValue(forKey: id)
    }
    
}
