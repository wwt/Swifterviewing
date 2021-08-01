//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class AlbumViewController: BaseViewController {
    @IBOutlet weak var albumTableView: UITableView!
    
    lazy var viewModel = AlbumViewModel()
    var albums = [Album]()
    var photos = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Here we have lot many records it is good to use pagination but API don't have such loading as it is
        self.showOverlay()
        viewModel.fetchData { [unowned self] error in
            if let error = error {
                self.showAlert(title: Constants.Alert.error, message: error.localizedDescription)
            }else {
                self.albums = viewModel.albums
                self.photos = viewModel.photos
                self.albumTableView.estimatedRowHeight = 500
                self.albumTableView.estimatedSectionHeaderHeight = 500
                self.albumTableView.reloadData()
            }
            self.hideOverLay()
        }
    }
    
}

extension AlbumViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        albums.count
    }
    
    // Matching id from album and albumId in photos and showing respectived albums under album
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let id = albums[section].id 
        return photos.filter { $0.albumId == id }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.album, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        let id = albums[indexPath.section].id
        let photo = photos.filter {$0.albumId == id}[indexPath.row]
        cell.configCell(data: photo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.albumHeader) as? AlbumHeaderTableViewCell else {
            return UITableViewCell()
        }
        var title = albums[section].title ?? ""
        header.albumTitle.text = title.removeCharacter()
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AlbumViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Alert.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
