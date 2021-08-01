//
//  AlbumTableViewCell.swift
//  Swifterviewing
//
//  Created by SOWJI on 01/08/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    
    func configCell(data: Photos) {
        var title = data.title ?? ""
        self.albumTitle.text = title.removeCharacter()
        if let url = URL(string: data.thumbnailUrl ?? "") {
        self.albumImage.downloadedFrom(url)
        }
    }
}
