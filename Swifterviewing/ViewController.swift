//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let albumVM = AlbumViewModel()
    private var collectionView: UICollectionView?
    private var datasource: UICollectionViewDiffableDataSource<Int, Album>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDatasource()
    }
}

// MARK: - helper function
extension ViewController {
    private func setup() {
        title = "Album sans e"
        albumVM.delegate = self
        
        let layout = getLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -16)
        ])
        
        collectionView.delegate = self

        self.collectionView = collectionView
    }
    
    private func getLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let idealItemRect = CGSize(width: 166, height: 216)
        let idealWidth = idealItemRect.width + 32
        let screenWidth = view.safeAreaLayoutGuide.layoutFrame.width
        let scale = screenWidth/idealWidth

        layout.itemSize = CGSize(width: idealItemRect.width*scale/2, height: idealItemRect.height*scale/2)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return layout
    }
    
    func setupDatasource(){
        guard let collectionView = collectionView else { return }
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: "AlbumCell")
        datasource = UICollectionViewDiffableDataSource<Int, Album>(
            collectionView: collectionView
        ){ (collectionView, indexPath, album) in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? AlbumCell {
                cell.setCell(album)
                return cell
            }
            return UICollectionViewCell()
        }
    }    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ViewController: AlbumViewModelDelegate {
    func onUpdate() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Album>()
        snapshot.appendSections([0])
        snapshot.appendItems(albumVM.albums)
        datasource?.apply(snapshot, animatingDifferences: true)
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
