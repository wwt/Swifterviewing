//
//  AlbumCell.swift
//  Swifterviewing
//
//  Created by Bejgum Shirisha on 30/10/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var albumTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
