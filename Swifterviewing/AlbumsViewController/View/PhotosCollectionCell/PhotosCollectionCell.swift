//
//  PhotosCollectionCell.swift
//  Swifterviewing
//
//  Created by Dharma Teja Kanneganti on 10/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class PhotosCollectionCell: UICollectionViewCell {
    @IBOutlet var imgvwPhoto: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
       
        //Applying style
        lblTitle.applyStyle(font: UIFont.regularStyle(size: 12.0), textColor: .black)
    }
}
