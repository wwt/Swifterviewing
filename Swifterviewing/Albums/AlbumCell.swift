//
//  AlbumCell.swift
//  Swifterviewing
//
//  Created by Robert Daly on 9/22/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    let albumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
        
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup(){
        let hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.spacing = 8
        hStack.axis = .horizontal
        hStack.alignment = .fill
        hStack.addArrangedSubview(albumImageView)
        hStack.addArrangedSubview(albumLabel)
        addSubview(hStack)
        
        let guide = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            albumImageView.widthAnchor.constraint(equalToConstant: 50),
            albumImageView.heightAnchor.constraint(equalToConstant: 50),
            hStack.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8),
            hStack.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8),
            hStack.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
            hStack.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -8),
        ])
        
    }

    func setCell(_ album: Album){
        albumLabel.text = album.title
        backgroundColor = .cyan
        selectionStyle = .none
    }
}
