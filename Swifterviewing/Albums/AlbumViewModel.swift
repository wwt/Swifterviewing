//
//  AlbumViewModel.swift
//  Swifterviewing
//
//  Created by Robert Daly on 9/20/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import Combine

protocol ListViewModelDelegate: AnyObject {
    func onUpdate()
}

final class AlbumViewModel {
    
    var albums: [Album] = []
    weak var delegate: ListViewModelDelegate?
    
    private var bindings = Set<AnyCancellable>()

    // MARK: - private vars
    private var api: API = API<Album>()
    private var start = 0
    private var limit = 100

    init(){
        fetchAlbums()
    }
    
    // MARK: - helper method
    private func fetchAlbums(){
        api.getSessionPublisher(
            .albums(start, limit),
            bindings: &bindings
        ) { [weak self] in
            self?.albums.append(contentsOf: $0)
            DispatchQueue.main.sync {
                self?.delegate?.onUpdate()
            }
        }
        
    
        start += limit
    }
}
