//
//  CollectionViewCell.swift
//  Swifterviewing
//
//  Created by Robert Daly on 9/20/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

// TODO: remember to remove 'e'
class AlbumCell: UICollectionViewCell {
    
    let vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        return vStack
    }()
    
    let albumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        setup()
    }

    private func setup(){
        albumImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        vStack.addSubview(albumImageView)
        vStack.addSubview(albumLabel)
    }
    
    func setCell(_ album: Album){
        albumImageView.image = album.image
        albumLabel.text = album.label
    }
    
}
