//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

// MARK: - API
struct API {
  
  // Properties
  private let baseURL = "https://jsonplaceholder.typicode.com/"
  private let photosEndpoint = "photos" //returns photos and their album ID
  private let albumsEndpoint = "albums" //returns an album, but without photos
  
  // Public Methods
  func getAlbums() async -> Result<[Album], APIError> {
    guard let url = URL(string: baseURL + albumsEndpoint) else {
      return .failure(.urlCreationError)
    }
    
    do {
      let (data, response) = try await URLSession.shared.data(from: url)
      
      let validationResult = validateTaskCompletion(data: data, response: response)
      
      switch validationResult {
      case.failure(let error):
        return .failure(error)
      case .success(let data):
        let albums = try JSONDecoder().decode([Album].self, from: data)
        albums.forEach({ $0.title = $0.title.replacingOccurrences(of: "e", with: "") })
        return .success(albums)
      }
    } catch {
      return .failure(.webServiceError(error))
    }
  }
  
  // Private Methods
  func getUniqueAlbumPhotos() async -> Result<[AlbumPhoto], APIError> {
    guard let url = URL(string: baseURL + photosEndpoint) else {
      return .failure(.urlCreationError)
    }
    
    do {
      let (data, response) = try await URLSession.shared.data(from: url)
      
      let validationResult = validateTaskCompletion(data: data, response: response)
      
      switch validationResult {
      case.failure(let error):
        return .failure(error)
      case .success(let data):
        let albumPhotos = try JSONDecoder().decode([AlbumPhoto].self, from: data).uniques(by: \.albumId)
        return .success(albumPhotos)
      }
    } catch {
      return .failure(.webServiceError(error))
    }
  }
  
  // Private methods
  private func validateTaskCompletion(data: Data?, response: URLResponse?) -> Result<Data, APIError> {
    guard let httpResponse = response as? HTTPURLResponse else {
      return .failure(.invalidResponse)
    }
    
    guard (200...299).contains(httpResponse.statusCode) else {
      return .failure(.httpError(httpResponse.statusCode))
    }
    
    guard let data = data else {
      return .failure(.dataNotReceived)
    }
    
    return .success(data)
  }

}

// MARK: - AlbumError
extension API {
  
  enum APIError: LocalizedError {
    
    // Error types
    case urlCreationError
    case webServiceError(Error)
    case invalidResponse
    case httpError(Int)
    case dataNotReceived
    case invalidDataReceived(Error)
    
    // Error descriptions
    var errorDescription: String? {
      switch self {
      case .urlCreationError:
        return NSLocalizedString("APIError - Unable to create endpoint url", comment: "")
      case .webServiceError(let error):
        return NSLocalizedString("APIError - Received error from webservice \(error.localizedDescription)",
                                 comment: "")
      case .invalidResponse:
        return NSLocalizedString("APIError - Invalid response received from server", comment: "")
      case .httpError(let errorCode):
        return NSLocalizedString("APIError - Received error code: \(errorCode)", comment: "")
      case .dataNotReceived:
        return NSLocalizedString("APIError - Data not received from server", comment: "")
      case .invalidDataReceived(let error):
        return NSLocalizedString("APIError - Invalid data. Parsing error: \(error.localizedDescription)", comment: "")
      }
    }
  }
  
}
