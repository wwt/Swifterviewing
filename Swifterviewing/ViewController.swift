//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let albumVM = AlbumViewModel()
    var collectionView: UICollectionView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Album sans e"
        setup()
    }
    
    private func setup() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -16)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self

        self.collectionView = collectionView
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albumVM.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = albumVM.albums[indexPath.item]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AlbumCell {
            cell.setCell(album)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        albums.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "6c570076-9d57-40f1-94d1-d6cd67ed23c6", for: indexPath)
//        cell.textLabel?.text = ""
//        cell.imageView?.image = UIImage()
//        return cell
//    }
//}
//
//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//}
