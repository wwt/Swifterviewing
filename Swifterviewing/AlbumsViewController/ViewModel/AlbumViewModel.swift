//
//  AlbumViewModel.swift
//  Swifterviewing
//
//  Created by Dharma Teja Kanneganti on 10/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class AlbumViewModel
{
    var albums:[Album] = []
    var photos:[Photos] = []
    var webService = WebService()
    var numberOfRows : Int {
        return albums.count
    }
    
    //MARK: -  cellDataAtIndex
    
    func cellDataAt(indexPath: IndexPath) -> Album? {
        return albums[indexPath.row]
    }
    
    func getPhotosFromAlbumId(albumId : Int) -> [Photos]
    {
        return photos.filter( {$0.albumId == albumId }).map({ return $0})
    }
    
    //MARK: - fetchAlbumsData
    
    func fetchAlbumsData(completion : @escaping ()->Void)
    {
        webService.fetchAlbumsData { arrAlbums, error in
            
            if let albumsData = arrAlbums as? NSArray, error == nil
            {
                for item in albumsData
                {
                    let album = try! JSONDecoder().decode(Album.self, from: JSONSerialization.data(withJSONObject: item))
                    self.albums.append(album)
                }
            }
            completion()
        }
    }
    
    //MARK: - fetchPhotosData
    
    func fetchPhotosData(completion : @escaping ()->Void)
    {
        webService.fetchPhotos { arrPhotos, error in
            
            if let arrPhotos = arrPhotos as? NSArray, error == nil
            {
                for item in arrPhotos
                {
                    let album = try! JSONDecoder().decode(Photos.self, from: JSONSerialization.data(withJSONObject: item))
                    self.photos.append(album)
                }
            }
            completion()
        }
    }
}
