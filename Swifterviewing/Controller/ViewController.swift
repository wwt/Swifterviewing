//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
  
  // IBOutlets
  @IBOutlet weak var tableView: UITableView!
  
  // Properties
  private var albums:[Album] = []
  
  // View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Task {
      await getData()
    }
  
  }
  
  // Private Methods
  private func getData() async {
    let api = API()
    
    let albumResult = await api.getAlbums()
    switch albumResult {
    case .failure(let error):
      print(error.errorDescription ?? "")
    case .success(let albums):
      self.albums = albums
      
      DispatchQueue.main.async() {
        self.tableView.reloadData()
      }
      
      await getPhotos()
    }
  }
  
  private func getPhotos() async {
    let api = API()
    
    let photoResult = await api.getUniqueAlbumPhotos()
    switch photoResult {
    case .failure(let error):
      print(error.errorDescription ?? "")
    case .success(let albumPhotos):
      for album in self.albums {
        album.thumbnailUrl = albumPhotos.filter({ $0.albumId == album.id }).first?.thumbnailUrl
      }
      
      DispatchQueue.main.async() {
        self.tableView.reloadData()
      }
    }
  }
  
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    albums.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "6c570076-9d57-40f1-94d1-d6cd67ed23c6", for: indexPath)
    cell.textLabel?.text = albums[indexPath.row].title
    cell.imageView?.contentMode = .scaleAspectFit
    
    if let urlString = albums[indexPath.row].thumbnailUrl,
       let url = URL.init(string: urlString) {
      cell.imageView?.kf.setImage(with: url, completionHandler: { _ in
        cell.setNeedsLayout()
      })
    }
    
    return cell
  }
  
}
