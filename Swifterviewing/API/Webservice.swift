//
//  Webservice.swift
//  Swifterviewing
//
//  Created by Dharma Teja Kanneganti on 10/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

typealias AlbumResponseStatus = (Bool) -> Void

class WebService
{
    //MARK: - fetchAlbumsData
    
    func fetchAlbumsData(completion: @escaping DFCompletion)
    {
        let service = BaseWebService.init()
        let fullUrl = API.baseURL + API.albumsEndpoint
        service.executeRequest(url: fullUrl,
                               method: .get,
                               parameters: nil,
                               headers: nil) { (response, error) in
                                completion(response, error)
        }
    }
    
    //MARK: - fetchPhotos
    
    func fetchPhotos(completion: @escaping DFCompletion)
    {
        let service = BaseWebService.init()
        let fullUrl = API.baseURL + API.photosEndpoint
        service.executeRequest(url: fullUrl,
                               method: .get,
                               parameters: nil,
                               headers: nil) { (response, error) in
                                completion(response, error)
        }
    }
}
