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
        vStack.alignment = .fill
        return vStack
    }()
    
    let albumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .brown
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
        vStack.addArrangedSubview(albumImageView)
        vStack.addArrangedSubview(albumLabel)
        addSubview(vStack)
        
        let guide = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8),
            vStack.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8),
            vStack.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
            vStack.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -8),
        ])
        
    }
    
    func setCell(_ album: Album){
//        albumImageView.image = album.image
        albumLabel.text = album.title
        backgroundColor = .cyan
    }
    
}
