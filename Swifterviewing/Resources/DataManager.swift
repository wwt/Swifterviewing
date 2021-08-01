//
//  DataManager.swift
//  Swifterviewing
//
//  Created by SOWJI on 01/08/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class DataManager {
    
    // Generic Getrequest using URLSession data task
    class func HTTPGetRequest<T: Decodable>( url : URL,completion:@escaping (Result<T,Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }else {
                guard let jsonData = data else { return }
                do {
                    let response = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    // Getrequest to return only Data
    class func HTTPGetDataRequest ( url : URL,completion:@escaping (Data)->Void) {
        URLSession.shared.dataTask(with: url) {  (data, response, error) in
            guard let jsonData = data else { return }
           completion(jsonData)
        }.resume()
    }
}
