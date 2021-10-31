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
    @IBOutlet weak var albumTableView: UITableView!
    var galleryInfo:Gallery = Gallery()
    var viewModel = AlbumViewModel()
    
    override func viewDidLoad() {
        self.albumTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier:cellIdentifier)
        self.viewModel.prepareAlbumsDataSource()
        self.viewModel.success = {(albums , photos) in
            DispatchQueue.main.async {
                self.galleryInfo.albums = albums
                self.galleryInfo.photos = photos
                self.albumTableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.galleryInfo.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier, for: indexPath) as! AlbumCell
        cell.albumTitle.sizeToFit()
        cell.albumTitle.numberOfLines = 0
        cell.albumTitle.text = viewModel.getAlbumTitle(indexPath:indexPath)
        let url = URL(string: self.galleryInfo.photos[indexPath.row].url!)
        cell.albumImageView.kf.setImage(with: url)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
//    func tableView(tableView: UITableView,
//        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
