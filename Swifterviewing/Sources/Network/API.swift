//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class API {
    
    let constants = URLConstants()

    func connectAPI(endPoint:String,successBlock :@escaping ((Data) -> Void), failureBlock :@escaping ((String) -> Void)){
        
        guard let url = URL(string:constants.kbaseURL + endPoint) else {
            return
        }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if error == nil {
                if data == nil{
                    failureBlock(error.debugDescription)
                }
                else{
                    //Check HTTP Status codes
                    if let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode != 200 {
                       failureBlock("Server Error")
                    }
                    else{
                        
                        if  String(data: data! , encoding: .utf8) != nil {
                            successBlock(data!)
                        }
                        else{
                            failureBlock(error.debugDescription)
                        }
                    }
                    
                }
            }
            else {
                failureBlock(error.debugDescription)
            }
            
        })
        task.resume()
    }
}

extension API {
    enum AlbumError: Error {
        case SomeRealisticErrorThing
    }
}
