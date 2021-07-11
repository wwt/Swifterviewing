//
//  BaseWebservice.swift
//  Swifterviewing
//
//  Created by Dharma Teja Kanneganti on 10/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import Alamofire
import TrustKit

public enum AlbumError {
    case generic
    case noNetwork
    case noData
}

typealias DFCompletion = (AnyObject?, Error?) -> Void

//MARK: - SessionDelegate

class BaseWebService: SessionDelegate {
    
    private var trustKitObj: TrustKit?
    var sessionManager: Session?

    init() {
        super.init()
        sessionManager = Session.init(configuration: URLSessionConfiguration.ephemeral, delegate: self)
        //                       // UIApplication.appDelegate.remoteConfigService?.string(forKey: .iOS_publickey_hash),
    }
    
    func executeRequest(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, completion: @escaping DFCompletion) {
        
        guard let requestUrl = URL(string: url) else {
            completion(nil, nil)
            return
        }
        
        sessionManager?.request(requestUrl,
                   method: method,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers,
                   interceptor: nil,
                   requestModifier: nil).responseJSON { (response) in
                    switch response.result {
                    case .success(let value):
                        if let jsonDict = value as? NSDictionary {
                            completion(jsonDict, nil)
                        }else if let jsonArray = value as? NSArray
                        {
                            completion(jsonArray, nil)
                        } else {
                            completion(nil, response.error)
                        }
                    case .failure:
                        completion(nil, response.error)
                    }
        }
        
    }
}

extension BaseWebService {
    
    //MARK: - Receiving Response
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) ->
                        Void) {
        completionHandler(.performDefaultHandling, nil)
        
         /*if let serverTrust = challenge.protectionSpace.serverTrust {
              let pinningValidator = TrustKit.sharedInstance().pinningValidator
            let trustDecision = pinningValidator.evaluateTrust(serverTrust, forHostname: API.baseURL)

              if trustDecision == .shouldAllowConnection {
                  completionHandler(.performDefaultHandling, nil)
              } else if trustDecision == .shouldBlockConnection {
                  completionHandler(.cancelAuthenticationChallenge, nil)
              } else {
                  completionHandler(.cancelAuthenticationChallenge, nil)
              }
          }*/
    }
}
