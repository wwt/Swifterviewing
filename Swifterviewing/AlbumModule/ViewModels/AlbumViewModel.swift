//
//  AlbumViewModel.swift
//  Swifterviewing
//
//  Created by Bejgum Shirisha on 30/10/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit
enum DataType : CustomStringConvertible {
  case Albums
  case Photos

  
  var description : String {
    switch self {
    // Use Internationalization, as appropriate.
    case .Albums: return "albums"
    case .Photos: return "photos"
    }
  }
}
class AlbumViewModel: NSObject {
    var failure    : ((String)->())? = nil
    var success        : (([Album],[Photo])->())? = nil
    let constants = URLConstants()
    
    private(set) var albums:[Album] = []
    private(set) var photos:[Photo] = []
    
    public func fetchAlbumInfo(){
        API().connectAPI(endPoint: constants.kalbumsEndpoint) { response in
            //Success Block
            do {
                print("Success : response")
                let albums = try JSONDecoder().decode([Album].self, from: response)
                self.albums = albums
            } catch {
                self.failure!(error.localizedDescription)
            }
        } failureBlock: { error in
            //Failure Block
            self.failure!(error)
        }


    }

    public func fetchData(dataType:DataType){
        API().connectAPI(endPoint:dataType.description) { response in
            //Success Block
            do {
                print("Success : response")
                if dataType.description == DataType.Albums.description {
                    self.albums = try JSONDecoder().decode([Album].self, from: response)
                    self.fetchData(dataType: DataType.Photos)
                }
                else{
                    self.photos = try JSONDecoder().decode([Photo].self, from: response)
                    self.success!(self.albums,self.photos)
                    
                }
            } catch {
                self.failure!(error.localizedDescription)
            }
        } failureBlock: { error in
            //Failure Block
            self.failure!(error)
        }
    }
    
    public func prepareAlbumsDataSource(){
        fetchData(dataType: DataType.Albums)

    }
    
    public func getAlbumTitle(indexPath:IndexPath) -> String{
       return Helpers.getAlbumTitle(title: self.albums[indexPath.row].title!, findString: "e", replaceWith: "")
    }
    
}
