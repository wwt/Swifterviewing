//
//  PhotoTableCell.swift
//  Swifterviewing
//
//  Created by Dharma Teja Kanneganti on 10/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class PhotoTableCell: UITableViewCell {
    @IBOutlet var vwContainer: UIView!
    @IBOutlet weak var lblPhotoTitle: UILabel!
    @IBOutlet var imgvwPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vwContainer.clipsToBounds = true
        vwContainer.makeCardView()
        vwContainer.layer.cornerRadius = 15.0
        lblPhotoTitle.applyStyle(font: UIFont.boldStyle(size: 16.0), textColor: .red)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
