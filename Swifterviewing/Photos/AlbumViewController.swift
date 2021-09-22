//
//  DetailViewController.swift
//  Swifterviewing
//
//  Created by Robert Daly on 9/22/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private var photoVM: PhotoViewModel?
    private var collectionView: UICollectionView?
    private var datasource: UICollectionViewDiffableDataSource<Int, Photo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDatasource()
    }
    
    
}

// MARK: - helper function
extension AlbumViewController {
    
    func createViewModel(_ id: Int){
        photoVM = PhotoViewModel(albumId: id)
    }
    
    private func setup() {
        navigationController?.view.backgroundColor = .systemBackground
        
        photoVM?.delegate = self
        
        let layout = getLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8),
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -8)
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
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        datasource = UICollectionViewDiffableDataSource<Int, Photo>(
            collectionView: collectionView
        ){ (collectionView, indexPath, photo) in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell {
                cell.setCell(photo)
                return cell
            }
            return UICollectionViewCell()
        }
    }
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension AlbumViewController: ListViewModelDelegate {
    func onUpdate() {
        guard let photos = photoVM?.photos else { return}
        var snapshot = NSDiffableDataSourceSnapshot<Int, Photo>()
        snapshot.appendSections([0])
        snapshot.appendItems(photos)
        datasource?.apply(snapshot, animatingDifferences: true)
    }
}
